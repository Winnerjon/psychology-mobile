import 'package:flutter/material.dart';
import 'package:psychology_mobile/common/navigation/go_router.dart';
import 'package:psychology_mobile/services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.initSharedPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Psychology',
      debugShowCheckedModeBanner: false,
      routerConfig: AppGoRouter.router,
    );
  }
}
