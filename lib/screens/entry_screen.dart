import 'package:flutter/material.dart';
import 'package:psychology_mobile/common/navigation/navigation_service.dart';
import 'package:psychology_mobile/models/user_model.dart';
import 'package:psychology_mobile/screens/first_screen.dart';
import 'package:psychology_mobile/services/db_service.dart';
import 'package:psychology_mobile/widgets/custom_background.dart';
import 'package:psychology_mobile/widgets/custom_dropdown.dart';
import 'package:psychology_mobile/widgets/custom_elevated_button.dart';
import 'package:psychology_mobile/widgets/custom_text_field.dart';

class EntryScreen extends StatefulWidget {
  static const String routeName = '/entry_screen';

  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final _key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final ageCtr = TextEditingController();
  final nationCtr = TextEditingController();
  final familyCountCtr = TextEditingController();
  final familyNumberCtr = TextEditingController();
  String? gender;
  String? yourClass;
  String? familyType;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: const SizedBox.shrink(),
          title: const Text(
            'Kirish',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    ctr: nameCtr,
                    title: 'Ismingiz',
                    hintText: 'Ism',
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdown(
                          title: 'Jinsingiz',
                          items: const ['Erkak', 'Ayol'],
                          item: gender,
                          onChange: (value) {
                            gender = value;
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomDropdown(
                          title: 'Sinfingiz',
                          items: const [
                            'Boshlang\'ich',
                            '5-sinf',
                            '6-sinf',
                            '7-sinf',
                            '8-sinf',
                            '9-sinf',
                            '10-sinf',
                            '11-sinf',
                            'Bitirganman'
                          ],
                          item: yourClass,
                          onChange: (value) {
                            yourClass = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          ctr: ageCtr,
                          keyboardType: TextInputType.number,
                          title: 'Yoshingiz',
                          hintText: 'Yosh',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          ctr: nationCtr,
                          title: 'Millatingiz',
                          hintText: 'Millat',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    ctr: familyCountCtr,
                    keyboardType: TextInputType.number,
                    title: 'Oilada nechta farzandsiz',
                    hintText: 'Soni',
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    ctr: familyNumberCtr,
                    keyboardType: TextInputType.number,
                    title: 'Oilada nechanchi farzandsiz',
                    hintText: 'Tartib raqami',
                  ),
                  const SizedBox(height: 22),
                  CustomDropdown(
                    title: 'Qanday oilada yashaysiz',
                    items: const [
                      'To`liq(ota-ona bilan)',
                      'Noto`liq(yoki ota, yoki ona bilan)',
                      'Yaqin qarindoshlar(bobo,buvi…..)'
                    ],
                    item: familyType,
                    onChange: (value) {
                      familyType = value;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 22),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: CustomElevatedButton(
            title: 'Kirish',
            onTap: () {
              if (_key.currentState!.validate()) {
                String name = nameCtr.text.trim();
                int age = int.parse(ageCtr.text.trim());
                String nation = nationCtr.text.trim();
                int familyCount = int.parse(familyCountCtr.text.trim());
                int familyNumber = int.parse(familyNumberCtr.text.trim());
                UserModel user = UserModel(
                    name: name,
                    gender: gender!,
                    yourClass: yourClass!,
                    age: age,
                    nation: nation,
                    familyCount: familyCount,
                    familyNumber: familyNumber,
                    familyType: familyType!);
                DbService.setLocalString(DbEnum.user, userModelToJson(user));
                NavigationService.go(context, FirstScreen.routeName);
              }
            },
          ),
        ),
      ),
    );
  }
}
