import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/components.dart';
import 'package:pet_app/core/shared/constants.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/features/profile/presentation/cubit/profile_setup_cubit.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  Map<String, List> viewContacts() => {
        'All': [1, 2],
        'Caretakers': [1],
        'Medical Care': [2, 3, 4],
        'Pet Walkers': [],
      };
  Widget contactsBody(BuildContext context, String title) {
    Widget contactItem(BuildContext context, dynamic item) {
      return ModedContainer(
        onTap: () => Constants.navigateTo(context, Routes.contactsDetails),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'email',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.adaptive.arrow_forward_outlined,
              color: SharedModeColors.grey500,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 20),
      itemCount: viewContacts()[title]!.length,
      itemBuilder: (context, index) => contactItem(
        context,
        viewContacts()[title]!.toList()[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        ProfileSetupCubit manager = ProfileSetupCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Contacts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => __infoListItem(
                        context,
                        viewContacts().keys.toList()[index],
                        index,
                        manager,
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: viewContacts().length,
                    ),
                  ),
                  contactsBody(
                    context,
                    viewContacts()
                        .keys
                        .toList()[manager.currentContactCategorySelection],
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: OutlinedGlobalButton(
            text: '+  Add new contact',
            onPressed: () {},
            margin: const EdgeInsets.all(20),
          ),
        );
      },
    );
  }

  Widget __infoListItem(
    BuildContext context,
    String title,
    int index,
    ProfileSetupCubit manager,
  ) {
    return ModedContainer(
      onTap: () => manager.changeContactsView(index),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      margin: EdgeInsets.zero,
      borderRadius: 8,
      selectedContainer: manager.currentContactCategorySelection == index
          ? SharedModeColors.yellow500
          : null,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: manager.currentContactCategorySelection == index
                  ? SharedModeColors.white
                  : null,
            ),
      ),
    );
  }
}
