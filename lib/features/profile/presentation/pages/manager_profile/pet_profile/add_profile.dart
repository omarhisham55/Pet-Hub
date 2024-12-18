import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_app/config/services/di/dpi.dart';
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
import 'package:pet_app/features/profile/presentation/cubit/add_pet_to_user_bloc.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

part 'package:pet_app/features/profile/presentation/widgets/add_pet_profile/add_pet_profile_widgets/add_pet_caretakers.dart';
part 'package:pet_app/features/profile/presentation/widgets/add_pet_profile/add_pet_profile_widgets/add_pet_details.dart';
part 'package:pet_app/features/profile/presentation/widgets/add_pet_profile/add_pet_profile_widgets/add_pet_overview.dart';
part 'package:pet_app/features/profile/presentation/widgets/add_pet_profile/add_pet_profile_widgets/add_pet_important_dates.dart';

class AddNewPetProfile extends StatelessWidget {
  const AddNewPetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPetBloc, AddPetState>(
      listener: (context, state) {
        if (state.responseStatus == ResponseStatus.error) {
          showToast(text: state.messageError ?? '', state: ToastStates.error);
        }
        if (state.responseStatus == ResponseStatus.success) {
          Constants.pop(context);
          Constants.pop(context);
          dpi<ProfileSetupCubit>().getUser();
          showToast(text: MainStrings.petAdded, state: ToastStates.success);
          dpi<ProfileSetupCubit>().drawerScaffoldKey.hideDrawer();
        }
      },
      child: Scaffold(
        appBar: TwoTitleAppbar(
          title: MainStrings.addProfile,
          centerTitle: true,
        ),
        body: profile(context),
        bottomSheet: BlocSelector<AddPetBloc, AddPetState, ResponseStatus>(
          selector: (state) => state.responseStatus ?? ResponseStatus.success,
          builder: (context, status) => status == ResponseStatus.loading
              ? Lottie.asset(LoadingLotties.paws,
                  height: 100, width: double.infinity)
              : GlobalButton(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  text: MainStrings.addToAccount,
                  onPressed: () {
                    context.read<AddPetBloc>().add(AddPetToUserEvent());
                  },
                ),
        ),
      ),
    );
  }

  Widget profile(BuildContext context, {bool? canEdit = false}) {
    final AddPetState newPet = context.read<AddPetBloc>().state;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 60),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AddPetOverView(state: newPet),
            AddPetDetails(state: newPet),
            AddPetImportantDates(state: newPet),
            AddPetCaretakes(state: newPet),
          ],
        ),
      ),
    );
  }
}
