import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/breed.dart';
// import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/caretakes.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/important_dates.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/name.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/size.dart';
import 'package:pet_app/features/profile/presentation/widgets/add_pet_profile_body/weight.dart';

Map<String, StatelessWidget> bodyContent = {
  'Breed': const Breed(),
  'Name': const PetName(),
  'Size': const PetSize(),
  'Weight': const PetWeight(),
  'Important dates': const ImportantDates(),
  // 'Caretakes': const CareTakes(),
};

addPetProfileBodyContent(ProfileSetupCubit manager) {
  return bodyContent.values.toList()[manager.setupPetProfileCurrentStep];
}

class SetProfileBodyMainContent extends StatelessWidget {
  final String title;
  final ProfileSetupCubit manager;
  final Widget child;
  final String? subTitle;
  final EdgeInsets? padding;
  const SetProfileBodyMainContent({
    super.key,
    required this.title,
    required this.manager,
    required this.child,
    this.subTitle = "",
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CircularAudioWave(
                  width: 200,
                  child: ClipOval(
                    child: Image.asset(
                      ProfileImages.noProfileSetup,
                    ),
                  ),
                ),
                if (bodyContent.keys.toList()[manager.setupPetProfileCurrentStep] == 'Name')
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: SharedModeColors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(Icons.image_outlined),
                    ),
                  ),
              ],
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          if (subTitle != "") const SizedBox(height: 10),
          Text(
            subTitle!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          Container(margin: const EdgeInsets.only(top: 10), child: child),
        ],
      ),
    );
  }
}
