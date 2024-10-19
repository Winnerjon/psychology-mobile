import 'package:flutter/material.dart';
import 'package:psychology_mobile/common/navigation/navigation_service.dart';
import 'package:psychology_mobile/models/user_model.dart';
import 'package:psychology_mobile/screens/entry_screen.dart';
import 'package:psychology_mobile/services/db_service.dart';
import 'package:psychology_mobile/widgets/custom_background.dart';
import 'package:psychology_mobile/widgets/custom_dropdown.dart';
import 'package:psychology_mobile/widgets/custom_elevated_button.dart';
import 'package:psychology_mobile/widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile_screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final ageCtr = TextEditingController();
  final nationCtr = TextEditingController();
  final familyCountCtr = TextEditingController();
  final familyNumberCtr = TextEditingController();
  String? gender;
  String? yourClass;
  String? familyType;

  UserModel? _getUser() {
    final data = DbService.getLocalString(DbEnum.user);
    if (data == null) return null;
    return userModelFromJson(data);
  }

  void _initState() {
    UserModel? user = _getUser();
    if (user != null) {
      nameCtr.text = user.name;
      ageCtr.text = user.age.toString();
      nationCtr.text = user.nation;
      familyCountCtr.text = user.familyCount.toString();
      familyNumberCtr.text = user.familyNumber.toString();
      gender = user.gender;
      yourClass = user.yourClass;
      familyType = user.familyType;
    }
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => NavigationService.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: const Text(
            "Profil",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                DbService.clearLocalData();
                NavigationService.go(context, EntryScreen.routeName);
              },
              icon: const Icon(Icons.logout, color: Colors.red),
            )
          ],
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
            title: 'Saqlash',
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
                NavigationService.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
