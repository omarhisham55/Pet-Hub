import 'package:flutter/material.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:pet_app/features/profile/presentation/widgets/appbars.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScan extends StatelessWidget {
  const QRCodeScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoTitleAppbar(
        context: context,
        title: 'Sharing profiles',
        subTitle: 'shared pet name',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _qrCode(context),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text('or'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            _shareLink(context),
          ],
        ),
      ),
    );
  }

  Widget _qrCode(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: SharedModeColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: SharedModeColors.grey200, blurRadius: 5),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: QrImageView(
              data: '1234567890',
              version: QrVersions.auto,
            ),
          ),
        ),
        Positioned(
          top: 30,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: SharedModeColors.white,
                radius: 50,
                child: ClipOval(
                  child: Image.asset(
                    ProfileImages.noProfileSetup,
                    width: 100,
                  ),
                ),
              ),
              Text(
                'pet Name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _shareLink(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SharedModeColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: SharedModeColors.grey200, blurRadius: 5),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Share invite link',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const Icon(Icons.share_outlined),
        ],
      ),
    );
  }
}
