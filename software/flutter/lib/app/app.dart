import 'package:fogoponics_system/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:fogoponics_system/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:fogoponics_system/ui/views/home/home_view.dart';
import 'package:fogoponics_system/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:fogoponics_system/services/firebase_service.dart';
import 'package:fogoponics_system/ui/views/control/control_view.dart';
import 'package:fogoponics_system/services/database_service.dart';
import 'package:fogoponics_system/ui/views/help/help_view.dart';
import 'package:fogoponics_system/services/plant_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: ControlView),
    MaterialRoute(page: HelpView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FirebaseService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: PlantService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
