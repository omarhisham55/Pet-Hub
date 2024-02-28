import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/body_manager.dart';

class PetSize extends StatelessWidget {
  const PetSize({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileSetupCubit manager = ProfileSetupCubit.get(context);
    return SetProfileBodyMainContent(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      title: "What's your pet's size?",
      subTitle:
          "Automatic selection based on your pet's breed. Adjust according to reality.",
      manager: ProfileSetupCubit.get(context),
      child: CarouselSlider(
        options: CarouselOptions(
          initialPage: manager.carouselIndex,
          aspectRatio: 2 / 1.1,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          viewportFraction: .5,
          enlargeFactor: 0.4,
          onScrolled: (value) => manager.changeFocus(value!.round()),
        ),
        items: List.generate(
          sizeInfo.length,
          (index) => _sizeCarouselItem(
            context,
            manager,
            sizeInfo.keys.toList()[index],
            sizeInfo.values.toList()[index],
            index,
          ),
        ),
      ),
    );
  }

  static const Map<String, String> sizeInfo = {
    'Small': 'under 14kg',
    'Medium': '14-25kg',
    'Large': 'over 24kg',
  };

  Widget _sizeCarouselItem(
    BuildContext context,
    ProfileSetupCubit manager,
    String key,
    String value,
    int index,
  ) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        final Color? focusedColor =
            manager.carouselIndex == index ? SharedModeColors.blue500 : null;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
            color: SharedModeColors.white,
            borderRadius: BorderRadius.circular(24),
            border: manager.carouselIndex == index
                ? Border.all(color: SharedModeColors.blue500, width: 2)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: focusedColor?.withOpacity(.5),
                radius: 25,
                child: Icon(
                  Icons.catching_pokemon_outlined,
                  color: focusedColor,
                ),
              ),
              Text(
                key,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: focusedColor),
              ),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: focusedColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
