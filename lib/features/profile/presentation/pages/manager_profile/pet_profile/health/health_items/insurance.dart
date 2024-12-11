import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/shared/components/buttons/global_outlined_button.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/profile/presentation/widgets/bottom_sheets/insurance_bottomsheets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Insurance extends StatelessWidget {
  const Insurance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        ProfileSetupCubit manager = ProfileSetupCubit.get(context);
        return SlidingUpPanel(
          controller: manager.panelInsuranceController,
          backdropColor: SharedModeColors.black,
          backdropEnabled: true,
          defaultPanelState: PanelState.CLOSED,
          onPanelClosed: () => manager.changePanel(),
          panel: _insurancePanel(context, manager),
          color: manager.isInsurancePanelOpen
              ? Theme.of(context).bottomSheetTheme.backgroundColor ??
                  SharedModeColors.grey500
              : Colors.transparent,
          boxShadow: const [],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          collapsed: _insuranceButton(context, manager),
          body: _insuranceEmptyBody(context),
        );
      },
    );
  }

  Widget _insuranceEmptyBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
      child: Column(
        children: [
          Image.asset(
            ProfileImages.emptyInsurance,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Text(
            'No insurance added',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Our pet insurance plans can help reimburse vet bills related to injuries and illnesses, helping provide a financial safety net for unplanned circumstances.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _insuranceButton(BuildContext context, ProfileSetupCubit manager) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: OutlinedGlobalButton(
        text: '+  Add insurance',
        onPressed: () {
          !manager.isInsurancePanelOpen
              ? {
                  manager.changePanel(),
                  manager.panelInsuranceController.open(),
                }
              : null;
        },
      ),
    );
  }

  Widget _header(BuildContext context, ProfileSetupCubit manager) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: SharedModeColors.grey500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  manager.insuranceCurrentStep != 0
                      ? GestureDetector(
                          onTap: () => manager.insurancePrevStep(context),
                          child: Icon(Icons.adaptive.arrow_back),
                        )
                      : Container(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Add Insurance',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        insuranceBottomSheets(manager.insuranceCurrentStep)[0],
                        style: Theme.of(context).textTheme.bodyMedium!,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Step',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '${manager.insuranceCurrentStep + 1}/${manager.insuranceMaxSteps}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 8,
                    decoration: BoxDecoration(
                      color: SharedModeColors.grey200,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(24),
                        minHeight: 8,
                        value: ProfileSetupCubit.get(context)
                                .insuranceCurrentStep /
                            ProfileSetupCubit.get(context).insuranceMaxSteps,
                        color: SharedModeColors.yellow500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _insurancePanel(BuildContext context, ProfileSetupCubit manager) {
    return manager.isInsurancePanelOpen
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _header(context, manager),
                  insuranceBottomSheets(manager.insuranceCurrentStep)[1],
                  GlobalButton(
                    text: 'Next',
                    onPressed: () => manager.insuranceNextStep(context),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
