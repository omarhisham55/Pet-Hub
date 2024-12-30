import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/features/home/presentation/cubit/add_pet_cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/home/presentation/widgets/add_pet_profile/wave_image_background_animation.dart';

addPetProfileBodyContent(AddPetBloc manager) {
  return manager.state.progress.child;
}

class SetProfileBodyMainContent extends StatelessWidget {
  final String title;
  final Widget child;
  final String subTitle;
  final EdgeInsets? padding;
  const SetProfileBodyMainContent({
    super.key,
    required this.title,
    required this.child,
    this.subTitle = "",
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<AddPetBloc, AddPetState>(
            builder: (context, state) {
              final manager = context.read<AddPetBloc>();
              return state.imgBytes == null
                  ? Stack(
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
                        if (manager.state.progress == AddPetStep.name)
                          GestureDetector(
                            onTap: () => manager.add(ImageEvent()),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: SharedModeColors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Icon(
                                  Icons.add_photo_alternate_outlined),
                            ),
                          ),
                      ],
                    )
                  : ClipOval(
                      child: ImageHandler(
                      imageBytes: state.imgBytes,
                      height: 200,
                    ));
            },
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          if (subTitle != "") const SizedBox(height: 10),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          Container(margin: const EdgeInsets.only(top: 10), child: child),
        ],
      ),
    );
  }
}
