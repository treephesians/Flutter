// private 값들은 불러올 수 있다.
import 'dart:io';

import 'package:calendar/model/category_color.dart';
import 'package:calendar/model/schedule_with_color.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../model/schedule.dart';
import 'package:path/path.dart' as p;
// private 값까지 불러올 수 있다.
part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  Future<Schedule> getScheduleById(int id) =>
      (select(schedules)..where((tbl) => tbl.id.equals(id))).getSingle();

  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    final query = select(schedules).join([
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId))
    ]);
    query.where(schedules.date.equals(date));
    query.orderBy(
      [
        // asc -> ascending 오름차순
        // desc -> descending 내림차순
        OrderingTerm.asc(schedules.startTime),
      ],
    );
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => ScheduleWithColor(
                  schedule: row.readTable(schedules),
                  categoryColor: row.readTable(categoryColors),
                ),
              )
              .toList(),
        );

    // ..은 함수의 결과가 return 되는 것이 아니라 실행된 대상이 return 되는 것이다!
    //(select(schedules)..where((tbl) => tbl.date.equals(date))).watch();
  }

  Future<int> updateScheduleById(int id, SchedulesCompanion data) =>
      (update(schedules)..where(((tbl) => tbl.id.equals(id)))).write(data);
  // 모든 스케줄이 삭제
  //removeSchedule() => delete(schedules).go();
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
