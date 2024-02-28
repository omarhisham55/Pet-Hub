import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class EmptyProfileStartUp extends StatelessWidget {
  const EmptyProfileStartUp({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileSetupCubit manager = ProfileSetupCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              ProfileImages.noProfileSetup,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Uh Oh!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Looks like you have no profiles set up at this moment, add your pet now',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          slideToContinueButton(context, manager),
        ],
      ),
    );
  }
}
