import 'package:calendar/component/calendar.dart';
import 'package:calendar/component/schedule_bottom_sheet.dart';
import 'package:calendar/component/schedule_card.dart';
import 'package:calendar/component/today_banner.dart';
import 'package:calendar/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
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
            TodayBanner(selectedDay: selectedDay, scheduleCount: 3),
            SizedBox(
              height: 8.0,
            ),
            _ScheduleList(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: PRIMARY_COLOR,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return ScheduleBottomSheet();
          },
        );
      },
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
  const _ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.0,
            );
          },
          itemBuilder: (context, index) {
            print(index);
            return ScheduleCard(
              startTime: 08,
              endTime: 09,
              content: "프로그래밍 공부하기. ${index}",
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
