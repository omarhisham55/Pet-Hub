part of 'package:pet_app/features/store/presentation/pages/pet_store_page.dart';

class ProductCategoryList extends StatelessWidget {
  const ProductCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetStoreCubit, PetStoreState>(
      builder: (context, state) {
        final PetStoreCubit cubit = context.read<PetStoreCubit>();
        final status = state.categoriesStatus;
        if (status == ResponseStatus.error ||
            status == ResponseStatus.loading ||
            status == ResponseStatus.initial) {
          return SizedBox.shrink();
        } else {
          if (state.categories.isEmpty) {
            return const Center(child: Text(MainStrings.noCategories));
          } else {
            return BlocSelector<PetStoreCubit, PetStoreState, List>(
              selector: (state) => [
                state.productCategory,
                state.productSubCategory,
              ],
              builder: (context, items) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (items[0] != null)
                          SlideInLeft(
                            child: IconButton(
                              onPressed: () => cubit.add(
                                ChangeProductCategoryEvent(category: null),
                              ),
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  ProductCategoryItem(
                                category: state.categories[index].category,
                                isSelected: items[0] == state.categories[index],
                                onTap: () => cubit.add(
                                  ChangeProductCategoryEvent(
                                    category: state.categories[index],
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              itemCount: state.categories.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (items[0] != null) const SizedBox(height: 10),
                    if (items[0] != null)
                      SlideInRight(
                        child: SizedBox(
                          height: 50,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, subIndex) =>
                                ProductCategoryItem(
                              category:
                                  items[0].subCategories[subIndex].subCategory,
                              isSelected:
                                  items[0].subCategories[subIndex] == items[1],
                              onTap: () => cubit.add(ChangeProductCategoryEvent(
                                category: items[0],
                                subCategory: items[0].subCategories[subIndex],
                              )),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemCount: items[0].subCategories.length,
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          }
        }
      },
    );
  }
}
