import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/colors.dart';

class BookADate extends StatelessWidget {
  const BookADate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book a date',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _calendar(context),
              _availability(context),
              _services(context),
              _addNotes(context),
              _confirmBooking(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calendar(BuildContext context) {
    return Column(
      children: [
        textSnap(
          context: context,
          text: 'Monday, ',
          snapText: '13 March',
          textStyle: Theme.of(context).textTheme.titleLarge,
          snapTextStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 70,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: SharedModeColors.white,
                boxShadow: const [BoxShadow(blurRadius: .01)],
              ),
              child: Column(
                children: [
                  Text((index + 1).toString()),
                  const Text('Sat'),
                ],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: 30,
          ),
        ),
      ],
    );
  }

  Widget _availability(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Wrap(
          children: List.generate(
            8,
            (index) => Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: SharedModeColors.white,
                boxShadow: const [BoxShadow(blurRadius: .01)],
              ),
              child: const Text('09:00'),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _services(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        ...List.generate(
          3,
          (index) => Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: SharedModeColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(blurRadius: .2)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Text(
                  'Haircut',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '\$30',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        const Text(
          'Prices are estimative and the payment will be made at the location',
        ),
        shadedDivider(),
      ],
    );
  }

  Widget _addNotes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add note',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        GlobalTextField(
          hintText: 'Suggested',
          controller: TextEditingController(),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _confirmBooking(BuildContext context) {
    return GlobalButton(
      text: 'Confirm booking',
      onPressed: () {},
    );
  }
}
