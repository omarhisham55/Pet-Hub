part of 'package:pet_app/features/health/presentation/pages/pet_health_page.dart';

class FindAVetSection extends StatelessWidget {
  const FindAVetSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List categories = [
      'Veterinarian',
      'Pet Dentist',
      'Genetic testing',
      'Pet nurse',
      'Pathology',
      'Cardiology',
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              MainStrings.findAVet,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(MainStrings.all),
            ),
          ],
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          padding: const EdgeInsets.only(top: 10),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            ...categories.map(
              (category) => ModedContainer(
                margin: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.home, size: 50),
                    Text(category, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
