import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _calendar(context)),
          Expanded(child: _upComingEvents(context)),
        ],
      ),
    );
  }

  Widget _calendar(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(DateTime.now().year - 1),
      lastDay: DateTime(DateTime.now().year + 3),
      focusedDay: DateTime.now(),
    );
  }

  Widget _upComingEvents(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shadedDivider(),
          Text(
            'Upcoming events',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemCount: 10,
              itemBuilder: (context, index) => const EventItem(),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ),
        ],
      ),
    );
  }
}
