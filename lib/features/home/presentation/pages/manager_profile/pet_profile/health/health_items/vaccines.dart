import 'package:flutter/material.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/home/presentation/cubit/profile_setup_cubit.dart';
import 'package:pet_app/features/home/presentation/widgets/bottom_sheets/vaccine_bottomsheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Vaccines extends StatelessWidget {
  const Vaccines({super.key});

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: ProfileSetupCubit.get(context).panelVaccineController,
      minHeight: 0,
      color: Theme.of(context).bottomSheetTheme.backgroundColor ??
          SharedModeColors.grey500,
      borderRadius: BorderRadius.circular(24),
      panel: const VaccineBottomSheetDetails(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).bottomSheetTheme.backgroundColor),
                      elevation: const MaterialStatePropertyAll(0),
                      hintText: 'Search by vaccine type',
                      hintStyle: MaterialStatePropertyAll(
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: SharedModeColors.grey500),
                      ),
                      leading: Icon(
                        Icons.search,
                        color: SharedModeColors.grey500,
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: SharedModeColors.grey500),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: SharedModeColors.blue500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: SharedModeColors.white,
                    ),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => _vaccineYear(context),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _vaccineYear(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            '2023',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => _vaccineitem(context),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: 3,
        ),
      ],
    );
  }

  Widget _vaccineitem(BuildContext context) {
    return ModedContainer(
      onTap: () => ProfileSetupCubit.get(context).panelVaccineController.open(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'vaccine name',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: SharedModeColors.grey500,
              ),
              Text(
                ' date ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '| dr name',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
