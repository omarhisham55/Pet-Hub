import 'package:flutter/material.dart';
import 'package:pet_app/config/theme/theme_manager.dart';
import 'package:pet_app/core/utils/colors.dart';
import 'package:pet_app/core/utils/strings.dart';

class ManagePetDropDownButton<T> extends StatelessWidget {
  final List<T> dropdownItems;
  final Function(T) onItemClick;
  final Map<T, Color> specifiedColors;
  final RelativeRect position;
  final Widget? child;
  const ManagePetDropDownButton({
    super.key,
    required this.dropdownItems,
    required this.onItemClick,
    this.specifiedColors = const {},
    this.position = const RelativeRect.fromLTRB(100, 100, 20, 0),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: ThemeManager.currentTheme == ThemeState.lightTheme
          ? SharedModeColors.grey150
          : SharedModeColors.grey800,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      onPressed: () {
        showMenu(
          context: context,
          position: position,
          items: dropdownItems.map((T item) {
            return PopupMenuItem<T>(
              value: item,
              child: child ??
                  Text(
                    item.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: specifiedColors[item]),
                  ),
            );
          }).toList(),
        ).then((value) {
          if (value != null) onItemClick(value);
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(MainStrings.manage),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
