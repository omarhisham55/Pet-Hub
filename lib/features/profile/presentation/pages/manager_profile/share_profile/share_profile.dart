import 'package:flutter/material.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';

class ShareProfile extends StatelessWidget {
  const ShareProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedModeColors.white,
      appBar: twoTitleAppbar(
        context: context,
        title: 'Sharing Profiles',
        centerTitle: true,
        elevation: 8,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: SharedModeColors.grey200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: SharedModeColors.yellow500,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Generate Code',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: SharedModeColors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        'Scan Code',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: SharedModeColors.grey500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ProfileSetupCubit.get(context).numberOfPets,
                itemBuilder: (context, index) => _petProfile(context),
              ),
              const Text(
                'Generate a QR code and invite link for each pet and easily syncronise data with other users',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _petProfile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () => Constants.navigateTo(context, Routes.qrCodeScan),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: SharedModeColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: SharedModeColors.grey200, blurRadius: 10),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 35,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pet Name',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Row(
                      children: [
                        Text('Dog | '),
                        Text('Border Collie'),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.male),
            ],
          ),
        ),
      ),
    );
  }
}
