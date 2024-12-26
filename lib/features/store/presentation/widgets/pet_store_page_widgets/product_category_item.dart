part of 'package:pet_app/features/store/presentation/pages/pet_store_page.dart';

class ProductCategoryItem extends StatelessWidget {
  final String category;
  final Function() onTap;
  final bool isSelected;
  const ProductCategoryItem({
    super.key,
    required this.category,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card.outlined(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isSelected
              ? BorderSide(color: SharedModeColors.grey500)
              : BorderSide.none,
        ),
        color: SharedModeColors.grey900,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
