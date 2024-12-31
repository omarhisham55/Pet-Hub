import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/shared/components/containers/moded_container.dart';
import 'package:pet_app/core/shared/components/text_fields/global_text_field.dart';

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
            itemBuilder: (context, index) => ModedContainer(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
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
            (index) => const ModedContainer(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              borderRadius: 10,
              child: Text('09:00'),
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
          (index) => ModedContainer(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.only(bottom: 10),
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
