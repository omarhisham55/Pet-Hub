import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/config/routes/routes.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';
import 'package:pet_app/core/shared/components/containers/moded_container.dart';
import 'package:pet_app/core/shared/components/custom_detailed_row.dart';
import 'package:pet_app/core/shared/constants/constants.dart';
import 'package:pet_app/features/home/presentation/cubit/pet_profile_cubit.dart';

class OpenMaps extends StatelessWidget {
  final String title;
  final String subTitle;
  const OpenMaps({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TwoTitleAppbar(
          title: subTitle,
          subTitle: title,
          titleAlignment: CrossAxisAlignment.start),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            buildingsEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            trafficEnabled: true,
            zoomControlsEnabled: kIsWeb ? true : false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(31.21966931084816, 29.94165211934725),
              zoom: 14.4746,
            ),
            onMapCreated: (controller) =>
                PetProfileCubit.get(context).setMapMarkers(),
            markers: PetProfileCubit.get(context).markers,
          ),
          _loactionDetails(context),
        ],
      ),
    );
  }

  Widget _loactionDetails(BuildContext context) {
    return ModedContainer(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      borderRadius: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const CircleAvatar(),
              const SizedBox(width: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Walker name',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '(3.5)',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Text(
                    'Walker name',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          CustomDetailedRow(value: MapEntry('Start Time', '09:30')),
          const Divider(),
          CustomDetailedRow(value: MapEntry('Distance', '2,7km')),
          const Divider(),
          CustomDetailedRow(value: MapEntry('Timer', '32:12min')),
        ],
      ),
    );
  }
}

class MapArguments {
  final String title;
  final String subTitle;

  MapArguments({required this.title, required this.subTitle});
}

class MapSmallView extends StatelessWidget {
  const MapSmallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(20),
      child: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(31.21966931084816, 29.94165211934725),
          zoom: 14.4746,
        ),
        onTap: (argument) => Constants.navigateTo(
          context,
          Routes.maps,
          arguments: MapArguments(
            title: '09.06.2023 | 09:30',
            subTitle: 'Morning Walk',
          ),
        ),
        onMapCreated: (controller) =>
            PetProfileCubit.get(context).setMapMarkers(),
        markers: PetProfileCubit.get(context).markers,
      ),
    );
  }
}
