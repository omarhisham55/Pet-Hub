// import 'package:flutter/material.dart';
// import 'package:pet_app/core/shared/components.dart';
// import 'package:pet_app/core/utils/image_manager.dart';

// class CareTakes extends StatelessWidget {
//   const CareTakes({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 20),
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   CircularAudioWave(
//                     width: 200,
//                     child: ClipOval(
//                       child: Image.asset(
//                         ProfileSetup.noProfileSetup,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           GlobalTextField(
//             hintText: 'Search by name, tag, email...',
//             controller: TextEditingController(),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 20),
//             child: Text(
//               'Added contacts',
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
