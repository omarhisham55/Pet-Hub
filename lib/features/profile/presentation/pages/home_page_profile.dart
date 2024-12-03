import 'package:flutter/material.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class HomePageProfile extends StatelessWidget {
  const HomePageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _petCarousel(context),
          _gridView(context),
        ],
      ),
    );
  }

  Widget _petCarousel(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active pet profile',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SmoothPageIndicator(
                axisDirection: Axis.vertical,
                controller: ProfileSetupCubit.get(context).pageController,
                count: ProfileSetupCubit.get(context).numberOfPets,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 3,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 170,
                  child: StackedCardCarousel(
                    pageController:
                        ProfileSetupCubit.get(context).pageController,
                    type: StackedCardCarouselType.fadeOutStack,
                    initialOffset: 0,
                    items: List.generate(
                      ProfileSetupCubit.get(context).numberOfPets,
                      (index) => GestureDetector(
                        onTap: () {
                          ProfileSetupCubit.get(context)
                              .changePetProfileView(0);
                          Constants.navigateTo(context, Routes.viewPetProfile);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: SharedModeColors.blue500,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(20),
                          height: 150,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Makki',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Dog | ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        Text(
                                          'Border Collie',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(ProfileImages.noProfileSetup),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gridView(BuildContext context) {
    Widget gridItem(context, List<Widget> items, Function() onTap) {
      return ModedContainer(
        onTap: onTap,
        borderRadius: 24,
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      );
    }

    return Expanded(
      // flex: 2,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          gridItem(
            context,
            [
              Text(
                'Share profile',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Text(
                'Easily share your pet\'s profile or add a new one',
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.adaptive.arrow_forward),
              ),
            ],
            () => Constants.navigateTo(context, Routes.shareProfile),
          ),
          gridItem(
            context,
            [
              Image.asset(ProfileImages.nutrition),
              Text(
                'Nutrition',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
            () {
              ProfileSetupCubit.get(context).changePetProfileView(2);
              Constants.navigateTo(context, Routes.viewPetProfile);
            },
          ),
          gridItem(
            context,
            [
              Image.asset(ProfileImages.healthCard),
              Text(
                'Health Card',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
            () {
              ProfileSetupCubit.get(context).changePetProfileView(1);
              Constants.navigateTo(context, Routes.viewPetProfile);
            },
          ),
          gridItem(
            context,
            [
              Image.asset(ProfileImages.activities),
              Text(
                'Activities',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
            () {
              ProfileSetupCubit.get(context).changePetProfileView(3);
              Constants.navigateTo(context, Routes.viewPetProfile);
            },
          ),
        ],
      ),
    );
  }
}
