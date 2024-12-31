part of 'package:pet_app/features/health/presentation/pages/pet_health_page.dart';

class UpcommingVetVisitsItem extends StatelessWidget {
  final String title;
  const UpcommingVetVisitsItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ModedContainer(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(Icons.home),
          const SizedBox(width: 10),
          Text(title),
          const Spacer(),
          GlobalButton(
            text: MainStrings.setReminder,
            expanded: false,
            color: SharedModeColors.red500,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
