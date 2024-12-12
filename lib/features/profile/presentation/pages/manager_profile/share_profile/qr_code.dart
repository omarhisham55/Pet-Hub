import 'package:flutter/material.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/shared/components/appbars/two_title_appbar.dart';
import 'package:pet_app/core/shared/components/components.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/image_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScan extends StatelessWidget {
  const QRCodeScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TwoTitleAppbar(
        title: 'Sharing profiles',
        subTitle: 'shared pet name',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _qrCode(context),
            Row(
              children: [
                Expanded(
                    child: Divider(
                  color: ThemeManager.currentTheme != ThemeState.lightTheme
                      ? SharedModeColors.grey200
                      : SharedModeColors.grey800,
                )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text('or'),
                ),
                Expanded(
                    child: Divider(
                  color: ThemeManager.currentTheme != ThemeState.lightTheme
                      ? SharedModeColors.grey200
                      : SharedModeColors.grey800,
                )),
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
        ModedContainer(
          margin: const EdgeInsets.only(top: 80),
          padding: const EdgeInsets.all(20),
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
                backgroundColor:
                    ThemeManager.currentTheme == ThemeState.lightTheme
                        ? SharedModeColors.grey200
                        : SharedModeColors.grey800,
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
    return ModedContainer(
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
