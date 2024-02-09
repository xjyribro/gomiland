// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';

class DropDownMenu extends StatelessWidget {
  final List<String> options;
  final Function onSelect;
  final String chosenValue;

  const DropDownMenu({
    super.key,
    required this.options,
    required this.onSelect,
    required this.chosenValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: chosenValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      dropdownColor: GameColors.blackTextColor,
      underline: Container(
        height: 0,
        color: GameColors.blackTextColor,
      ),
      onChanged: (String? newValue) {
        onSelect(newValue);
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value, style: TextStyles.menuGreenTextStyle,),
          ),
        );
      }).toList(),
    );
  }
}
