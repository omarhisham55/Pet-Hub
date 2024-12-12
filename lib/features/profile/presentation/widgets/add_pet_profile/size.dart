import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/presentation/cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile/body_manager.dart';

class PetSize extends StatelessWidget {
  const PetSize({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPetBloc cubit = context.read<AddPetBloc>();
    return SetProfileBodyMainContent(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      title: MainStrings.addPetSizeTitle,
      subTitle: MainStrings.addPetSizeSubtitle,
      child: CarouselSlider(
        options: CarouselOptions(
          initialPage: cubit.state.carouselIndex,
          aspectRatio: 2 / 1.1,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          viewportFraction: .5,
          enlargeFactor: 0.4,
          onScrolled: (value) => cubit.add(ChangeItemEvent(
            item: value!.round(),
          )),
        ),
        items: List.generate(
          MainStrings.sizeInfo.length,
          (index) => _sizeCarouselItem(context, index),
        ),
      ),
    );
  }

  Widget _sizeCarouselItem(BuildContext context, int index) {
    return BlocSelector<AddPetBloc, AddPetState, String>(
      selector: (state) => state.carouselIndex.toString(),
      builder: (context, selectedSize) {
        final bool isSelected = selectedSize == index.toString() ||
            (selectedSize.isEmpty && index == 0);
        final Color? focusedColor =
            isSelected ? SharedModeColors.blue500 : SharedModeColors.grey400;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
            color: SharedModeColors.white,
            borderRadius: BorderRadius.circular(24),
            border: isSelected
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
                MainStrings.sizeInfo.keys.toList()[index],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: focusedColor),
              ),
              Text(
                MainStrings.sizeInfo.values.toList()[index],
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
