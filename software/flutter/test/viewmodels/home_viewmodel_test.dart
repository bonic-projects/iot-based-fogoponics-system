import 'package:flutter_test/flutter_test.dart';
import 'package:fogoponics_system/services/firebase_service.dart';
import 'package:mockito/mockito.dart';
import 'package:fogoponics_system/app/app.bottomsheets.dart';
import 'package:fogoponics_system/app/app.locator.dart';
import 'package:fogoponics_system/ui/common/app_strings.dart';
import 'package:fogoponics_system/ui/views/home/home_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  HomeViewModel getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
