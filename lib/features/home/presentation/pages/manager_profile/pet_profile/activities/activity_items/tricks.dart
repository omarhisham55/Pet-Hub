import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components/buttons/global_outlined_button.dart';
import 'package:pet_app/core/shared/components/containers/moded_container.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';

class TricksActivity extends StatelessWidget {
  const TricksActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _yourTricks(context, '', ''),
            _learnMore(context),
            OutlinedGlobalButton(
              text: 'Learn new tricks',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _yourTricks(BuildContext context, String trick, String date) {
    Widget trick(BuildContext context) => GestureDetector(
          onTap: () {},
          child: ModedContainer(
            child: Row(
              children: [
                Expanded(
                  child: Image.asset(
                    ProfileImages.activities,
                    fit: BoxFit.contain,
                    height: 60,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Text(
                      'Paw',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your tricks',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Icon(Icons.more_horiz)
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => trick(context),
          itemCount: 2,
        ),
      ],
    );
  }

  Widget _learnMore(BuildContext context) {
    Widget skillItem(BuildContext context) => ModedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ProfileImages.activities),
              Text(
                'Lay Down',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: SharedModeColors.purple100,
                ),
                child: Text(
                  'Begginer',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: SharedModeColors.purple500),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: SharedModeColors.grey500,
                  ),
                  Text(
                    ' 3 minutes',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Learn next',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    'See all ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: SharedModeColors.blue500),
                  ),
                  Icon(
                    Icons.adaptive.arrow_forward,
                    color: SharedModeColors.blue500,
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          height: 240,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => skillItem(context),
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}
