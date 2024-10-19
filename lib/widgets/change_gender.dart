import 'package:flutter/material.dart';

class ChangeGender extends StatefulWidget {
  final String? selectGender;
  final Function(String) onTap;

  const ChangeGender(
      {super.key, this.selectGender, required this.onTap});

  @override
  State<ChangeGender> createState() => _ChangeGenderState();
}

class _ChangeGenderState extends State<ChangeGender> {
  String? selectGender;
  List<String> genders = ['Erkak', 'Ayol'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var element in genders) {
      if (element == widget.selectGender) {
        selectGender = element;
        break;
      }
    }
  }

  @override
  void didUpdateWidget(covariant ChangeGender oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      for (var element in genders) {
        if (element == widget.selectGender) {
          selectGender = element;
          setState(() {});
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectGender,
      validator: (value) {
        if (value == null) {
          return 'Kiritish shart';
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Jinsingiz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              children: List.generate(
                genders.length,
                (index) {
                  final gender = genders[index];
                  final isSelect = selectGender == gender;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        widget.onTap.call(gender);
                        state.didChange(gender);
                      },
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: index == genders.length - 1 ? 0 : 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                                  width: 1,
                                  color: isSelect ? Colors.white : Colors.grey),
                        ),
                        child: Text(
                          gender,
                          style: TextStyle(
                              color: isSelect ? Colors.white : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}
