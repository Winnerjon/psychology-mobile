import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:psychology_mobile/common/values/colors.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? item;
  final Function(String) onChange;

  const CustomDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.item,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: item,
      validator: (value) {
        if (value != null) return null;
        return 'Kiritish shart';
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                alignment: Alignment.bottomCenter,
                value: item,
                isExpanded: true,
                hint: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                items: items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                style: const TextStyle(color: Colors.white),
                onChanged: (String? newValue) {
                  if (newValue == null) return;
                  onChange.call(newValue);
                  state.didChange(newValue);
                },
                buttonStyleData: ButtonStyleData(
                  padding: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: state.hasError ? Colors.red : Colors.grey, width: 0.5),
                  ),
                ),
                dropdownStyleData: const DropdownStyleData(
                    decoration: BoxDecoration(color: AppColors.mainColor)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(state.errorText ?? '', style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w300),),
            ),
          ],
        );
      },
    );
  }
}
