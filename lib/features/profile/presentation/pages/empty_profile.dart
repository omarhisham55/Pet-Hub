import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/profile/presentation/widgets/slide_to_continue_button.dart';

class EmptyProfileStartUp extends StatelessWidget {
  const EmptyProfileStartUp({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: MainStrings.userEmptyPets.split('\n')[0]+ '\n',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextSpan(
                    text: MainStrings.userEmptyPets.split('\n')[1],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SlideToContinueButton(),
        ],
      ),
    );
  }
}
