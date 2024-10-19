import 'package:flutter/material.dart';
import 'package:psychology_mobile/common/navigation/navigation_service.dart';
import 'package:psychology_mobile/screens/entry_screen.dart';
import 'package:psychology_mobile/screens/first_screen.dart';
import 'package:psychology_mobile/services/db_service.dart';
import 'package:psychology_mobile/widgets/custom_background.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void _initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      final data = DbService.getLocalString(DbEnum.user);
      if (data != null) {
        NavigationService.go(context, FirstScreen.routeName);
      } else {
        NavigationService.go(context, EntryScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      isGradient: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: MediaQuery.viewPaddingOf(context).bottom + 50),
          child: const Text(
            'O\'smirlarda qadriyatli omillar va ularni aniqlash jihatlari ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
