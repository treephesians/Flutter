import 'package:calendar/component/calendar.dart';
import 'package:calendar/component/schedule_bottom_sheet.dart';
import 'package:calendar/component/schedule_card.dart';
import 'package:calendar/component/today_banner.dart';
import 'package:calendar/constant/colors.dart';
import 'package:calendar/database/drift_database.dart';
import 'package:calendar/model/schedule_with_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: FutureBuilder<Schedule>(
          future: null,
          builder: (context, snapshot) {
            return SafeArea(
              child: Column(
                children: [
                  Calender(
                    onDaySelected: onDaySelected,
                    focusedDay: focusedDay,
                    selectedDay: selectedDay,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TodayBanner(selectedDay: selectedDay),
                  SizedBox(
                    height: 8.0,
                  ),
                  _ScheduleList(
                    selectedDate: selectedDay,
                  ),
                ],
              ),
            );
          }),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: PRIMARY_COLOR,
      onPressed: () {},
      child: Icon(
        Icons.add,
      ),
    );
  }

  onDaySelected(selectedDay, focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
      //print(selectedDay);
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;

  const _ScheduleList({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<ScheduleWithColor>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text('스케줄이 없습니다.'),
                );
              }
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.0,
                  );
                },
                itemBuilder: (context, index) {
                  //print(index);
                  final scheduleWithColor = snapshot.data![index];
                  return Dismissible(
                    // key값으로 어느것이 삭제되었는지 확인한다.
                    key: ObjectKey(scheduleWithColor.schedule.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection direction) {
                      // 이 때 삭제쿼리를 넣어줘야 한다.
                      GetIt.I<LocalDatabase>()
                          .removeSchedule(scheduleWithColor.schedule.id);
                    },
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return ScheduleBottomSheet(
                              selectedDate: selectedDate,
                              scheduleId: scheduleWithColor.schedule.id,
                            );
                          },
                        );
                      },
                      child: ScheduleCard(
                        startTime: scheduleWithColor.schedule.startTime,
                        endTime: scheduleWithColor.schedule.endTime,
                        content: scheduleWithColor.schedule.content,
                        color: Color(
                          int.parse(
                              'FF${scheduleWithColor.categoryColor.hexCode}',
                              radix: 16),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
