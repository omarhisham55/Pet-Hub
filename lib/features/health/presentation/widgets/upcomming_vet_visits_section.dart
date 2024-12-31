part of 'package:pet_app/features/health/presentation/pages/pet_health_page.dart';

class UpcommingVetVisitsSection extends StatelessWidget {
  const UpcommingVetVisitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List visits = [];
    // final List visits = ['Wellness check-up', 'Vaccination', 'Deworming'];
    return visits.isEmpty ? _emptyVetVisits() : _vetVisitsBody(context, visits);
  }

  Widget _emptyVetVisits() {
    return ErrorWidgetAndRetry(
      errorMessage: MainStrings.noUpcommingVetVisits,
      buttonText: MainStrings.scheduleAnAppointment,
      retryFunction: () {},
    );
  }

  Widget _vetVisitsBody(BuildContext context, List visits) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              MainStrings.upcommingVetVisits,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(MainStrings.all),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visits.length <= 3 ? visits.length : 3,
          itemBuilder: (context, index) => UpcommingVetVisitsItem(
            title: visits[index],
          ),
        ),
      ],
    );
  }
}
