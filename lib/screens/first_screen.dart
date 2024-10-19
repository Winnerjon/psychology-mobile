import 'package:flutter/material.dart';
import 'package:psychology_mobile/common/navigation/navigation_service.dart';
import 'package:psychology_mobile/models/saved_result_model.dart';
import 'package:psychology_mobile/models/user_model.dart';
import 'package:psychology_mobile/screens/profile_screen.dart';
import 'package:psychology_mobile/screens/quiz_screen.dart';
import 'package:psychology_mobile/services/db_service.dart';
import 'package:psychology_mobile/services/result_service.dart';
import 'package:psychology_mobile/widgets/custom_background.dart';
import 'package:psychology_mobile/widgets/custom_elevated_button.dart';

class FirstScreen extends StatefulWidget {
  static const String routeName = '/first_screen';

  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<SavedResultModel> allResults = [];
  UserModel? user;

  UserModel? _getUser() {
    final data = DbService.getLocalString(DbEnum.user);
    if (data == null) return null;
    return userModelFromJson(data);
  }

  @override
  void initState() {
    user = _getUser();
    allResults = ResultService.fetchAllResults();
    if(mounted) setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      isGradient: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Assalomu alaykum, ${user?.name}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy'),
          ),
          actions: [
            IconButton(
              onPressed: () {
                NavigationService.push(context, ProfileScreen.routeName);
              },
              icon: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Testni boshlashga tayyormisiz',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gilroy'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomElevatedButton(
            onTap: () {
              NavigationService.push(context, QuizScreen.routeName).then((value) {
                allResults = ResultService.fetchAllResults();
                setState(() {});
              });
            },
            title: 'Boshlash',
          ),
        ),
      ),
    );
  }
}
