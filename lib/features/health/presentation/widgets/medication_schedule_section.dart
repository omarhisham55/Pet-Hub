part of 'package:pet_app/features/health/presentation/pages/pet_health_page.dart';

class MedicationScheduleSection extends StatelessWidget {
  const MedicationScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List medications = [
      'Flea prevention',
      'Dental chews',
      'Emergency kit',
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              MainStrings.medicalSchedule,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(MainStrings.allRecords),
            ),
          ],
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 10),
            scrollDirection: Axis.horizontal,
            itemCount: medications.length <= 5 ? medications.length : 5,
            itemBuilder: (context, index) => ModedContainer(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, size: 50),
                  Text(medications[index]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
