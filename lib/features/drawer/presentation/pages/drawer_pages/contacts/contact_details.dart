import 'package:flutter/material.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/components/appbars/contact_sliver_appbar.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/shared/components/containers/moded_container.dart';
import 'package:pet_app/core/shared/components/custom_detailed_row.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/home/presentation/pages/manager_profile/pet_profile/activities/activity_items/open_maps.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          ContactSliverAppbar(),
        ],
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _contactTitle(context),
            _review(context),
            _contactInfo(context),
            _contactLocation(context),
            _availability(context),
            _services(context),
            _buttonActions(context)
          ],
        ),
      ),
    );
  }

  Widget _contactTitle(BuildContext context) {
    return ModedContainer(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shining Fur Salon',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Grooming',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Expanded(
              child: Image.asset(
            ProfileImages.haircutSalon,
            height: 80,
            fit: BoxFit.cover,
          )),
        ],
      ),
    );
  }

  Widget _review(BuildContext context) {
    return Row(
      children: [
        Text(
          '4,6 ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ...List.generate(
          5,
          (index) => Icon(
            Icons.star,
            color: SharedModeColors.yellow500,
          ),
        ),
        const Spacer(),
        const Text('230 reviews'),
      ],
    );
  }

  Widget _contactInfo(BuildContext context) {
    return Column(
      children: [
        shadedDivider(),
        CustomDetailedRow(value: MapEntry('Contact', '-')),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '079 1234 7777',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:
                            ThemeManager.currentTheme == ThemeState.lightTheme
                                ? SharedModeColors.black
                                : SharedModeColors.white,
                      ),
                ),
              ],
            ),
            const Icon(Icons.call),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'contactshinnyfun@gmail.com',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:
                            ThemeManager.currentTheme == ThemeState.lightTheme
                                ? SharedModeColors.black
                                : SharedModeColors.white,
                      ),
                ),
              ],
            ),
            const Icon(Icons.share),
          ],
        ),
        shadedDivider(),
      ],
    );
  }

  Widget _contactLocation(BuildContext context) {
    return Column(
      children: [
        CustomDetailedRow(value: MapEntry('Location', '-')),
        const SizedBox(height: 10),
        textSnap(
          context: context,
          text: 'Street: ',
          snapText: '70 North Street',
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: SharedModeColors.grey500),
        ),
        textSnap(
          context: context,
          text: 'City: ',
          snapText: 'London',
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: SharedModeColors.grey500),
        ),
        textSnap(
          context: context,
          text: 'Country: ',
          snapText: 'United Kingdom',
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: SharedModeColors.grey500),
        ),
        const MapSmallView(),
        shadedDivider(),
      ],
    );
  }

  Widget _availability(BuildContext context) {
    return Column(
      children: [
        CustomDetailedRow(value: MapEntry('Availability', '-')),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            7,
            (index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: SharedModeColors.blue100,
              ),
              child: Text(
                'M',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: SharedModeColors.blue500),
              ),
            ),
          ),
        ),
        textSnap(
          context: context,
          text: 'Hours: ',
          snapText: '10:00 - 20:00',
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: SharedModeColors.grey500),
        ),
        shadedDivider(),
      ],
    );
  }

  Widget _services(BuildContext context) {
    return Column(
      children: [
        CustomDetailedRow(value: MapEntry('Services', '-')),
        const SizedBox(height: 10),
        ...List.generate(
          3,
          (index) => ModedContainer(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buttonActions(BuildContext context) {
    return Column(
      children: [
        GlobalButton(
          text: 'Book a date',
          onPressed: () => Constants.navigateTo(context, Routes.bookADate),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {},
          child: Text(
            '+  Add to contacts',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
