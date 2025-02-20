import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fogoponics_system/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:fogoponics_system/services/firebase_service.dart';
import 'package:fogoponics_system/services/database_service.dart';
import 'package:fogoponics_system/services/plant_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FirebaseService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DatabaseService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<PlantService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterFirebaseService();
  getAndRegisterDatabaseService();
  getAndRegisterPlantService();
// @stacked-mock-register
}

NavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = NavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

DialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = DialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

FirebaseService getAndRegisterFirebaseService() {
  _removeRegistrationIfExists<FirebaseService>();
  final service = FirebaseService();
  locator.registerSingleton<FirebaseService>(service);
  return service;
}

MockDatabaseService getAndRegisterDatabaseService() {
  _removeRegistrationIfExists<DatabaseService>();
  final service = MockDatabaseService();
  locator.registerSingleton<DatabaseService>(service);
  return service;
}

MockPlantService getAndRegisterPlantService() {
  _removeRegistrationIfExists<PlantService>();
  final service = MockPlantService();
  locator.registerSingleton<PlantService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
