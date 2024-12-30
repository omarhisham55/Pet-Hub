import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';
import 'package:pet_app/core/shared/components/buttons/global_filled_button.dart';
import 'package:pet_app/core/shared/components/custom_detailed_row.dart';
import 'package:pet_app/core/shared/components/date_row.dart';
import 'package:pet_app/core/shared/components/image_handler.dart';
import 'package:pet_app/core/shared/components/toast.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/core/shared/constants/enums.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/core/utils/strings.dart';
import 'package:pet_app/features/home/data/models/pet_model.dart';
import 'package:pet_app/features/home/domain/entities/pet.dart';
import 'package:pet_app/features/home/presentation/cubit/add_pet_cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/home/presentation/cubit/navigation_cubit/navigation_cubit.dart';

part 'package:pet_app/features/home/presentation/widgets/add_pet_profile/add_pet_profile_widgets/add_pet_caretakers.dart';
part 'package:pet_app/features/home/presentation/widgets/add_pet_profile/add_pet_profile_widgets/add_pet_details.dart';
part 'package:pet_app/features/home/presentation/widgets/add_pet_profile/add_pet_profile_widgets/add_pet_overview.dart';
part 'package:pet_app/features/home/presentation/widgets/add_pet_profile/add_pet_profile_widgets/add_pet_important_dates.dart';

class AddNewPetProfile extends StatelessWidget {
  final Pet pet;
  const AddNewPetProfile({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPetBloc, AddPetState>(
      listener: (context, state) {
        if (state.responseStatus == ResponseStatus.error) {
          showToast(text: state.messageError ?? '', state: ToastStates.error);
        }
        if (state.responseStatus == ResponseStatus.success) {
          Constants.removeAllAndAddNewRoute(context, Routes.navigationManager);
          showToast(text: MainStrings.petAdded, state: ToastStates.success);
          context.read<NavigationCubit>().drawerScaffoldKey.hideDrawer();
        }
      },
      child: Scaffold(
        appBar: TwoTitleAppbar(
          title: MainStrings.addProfile,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            profile(context, pet),
            BlocSelector<AddPetBloc, AddPetState, ResponseStatus>(
              selector: (state) =>
                  state.responseStatus ?? ResponseStatus.success,
              builder: (context, status) => status == ResponseStatus.loading
                  ? Lottie.asset(LoadingLotties.paws,
                      height: 100, width: double.infinity)
                  : GlobalButton(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      text: MainStrings.addToAccount,
                      onPressed: () {
                        context
                            .read<AddPetBloc>()
                            .add(AddPetToUserEvent(pet: pet as PetModel));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profile(BuildContext context, Pet pet, {bool? canEdit = false}) {
    return Column(
      children: [
        AddPetOverView(pet: pet),
        AddPetDetails(pet: pet),
        AddPetImportantDates(pet: pet),
        AddPetCaretakes(pet: pet),
      ],
    );
  }
}
