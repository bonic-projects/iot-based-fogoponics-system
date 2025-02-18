import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fogoponics_system/app/app.bottomsheets.dart';
import 'package:fogoponics_system/app/app.dialogs.dart';
import 'package:fogoponics_system/app/app.locator.dart';
import 'package:fogoponics_system/app/app.router.dart';
import 'package:fogoponics_system/services/firebase_service.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
