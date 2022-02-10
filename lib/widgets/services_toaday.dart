import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/models/categories/category_model.dart';
import 'package:htask/models/service_model.dart';
import 'package:htask/screens/home/cubit/home_cubit.dart';
import 'package:htask/screens/home/cubit/home_states.dart';
import 'package:htask/screens/login/cubit/auth_cubit.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/widgets/service_item.dart';

class ServiceToday extends StatelessWidget {
  const ServiceToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your service today are: '),
        Expanded(flex: 2, child: Container()),
        Expanded(
          flex: 4,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is LoadingAllCategoriesHomeState ||
                  state is LoadingAllOrdersHomeState) {
                return const Center(child: CircularProgressIndicator());
              }
              final categories =
                  HomeCubit.instance(context).allCategories.categories;
              final selectedIndex =
                  HomeCubit.instance(context).selectedCategoryIndex;
              return Row(
                children: [
                  _SelectAll(
                    selectAllCategories: SelectAllCategories(0),
                    selected: selectedIndex == null,
                  ),
                  const VerticalDivider(thickness: 1),
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 15,
                            ),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                              onTap: () {
                                HomeCubit.instance(context)
                                    .changeSelectedCategory(context,
                                        index: index);
                              },
                              child: ServiceItem(
                                selected: selectedIndex != null &&
                                    selectedIndex == index,
                                category: categories[index],
                              ));
                        }),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class _SelectAll extends StatelessWidget {
  const _SelectAll(
      {Key? key, required this.selectAllCategories, required this.selected})
      : super(key: key);
  final SelectAllCategories selectAllCategories;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HomeCubit.instance(context).changeSelectedCategory(context);
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: selected
                ? AppColors.selectedColor
                : AppColors.selectedColor.withOpacity(0.6),
            child: ClipOval(child: Text(selectAllCategories.name)),
            radius: 20,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
