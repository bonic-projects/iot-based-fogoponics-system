import 'package:firebase_database/firebase_database.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.router.dart';
import '../../../models/device_data.dart';
import '../../../services/firebase_service.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = NavigationService();
  final SnackbarService _snackbarService = SnackbarService();
  final _firebaseService=FirebaseService();
  final FirebaseDatabase _dbref = FirebaseDatabase.instance;
  String dbcode = "uxCwM1edkQgSqE7NTtIo0gzEHJY2";
  bool _isAutomaticMode = true;
  bool get isAutomaticMode => _isAutomaticMode;

  HomeViewModel() {
    listenToDeviceReadings(); // Start real-time listener when ViewModel is created
  }

  int currentMode = 0;
  double temperature = 0.0;
  double humidity = 0.0;
  double lightIntensity = 0.0;

  void listenToDeviceReadings() {
    _dbref.ref().child('devices/$dbcode/reading').onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.exists) {
        final data = snapshot.value;

        print("Updated Data: $data"); // Debugging output

        if (data is Map<dynamic, dynamic>) {
          final readings = [DeviceReading.fromMap(data)];

          // Update ViewModel variables
          if (readings.isNotEmpty) {
            final latestReading = readings.last;
            temperature = latestReading.temperature;
            humidity = latestReading.humidity;
            lightIntensity = latestReading.light;

            print("Updated UI: Temperature: $temperature, Humidity: $humidity, Light: $lightIntensity");

            notifyListeners(); // Update UI in real-time
          }
        } else {
          print("Unexpected data format: ${data.runtimeType}");
        }
      }
    });
  }

  Future<void> init() async {
    try {
      print("Fetching status and mode...");
      _isAutomaticMode = await _firebaseService.getStatus();
      currentMode = await _firebaseService.getMode();
      print("Status: $_isAutomaticMode, Mode: $currentMode");

      print("Listening for real-time device readings...");
      listenToDeviceReadings(); // Start listening to updates

    } catch (e) {
      print("Error initializing data: $e");
    }
  }


  // Helper methods remain the same
  String getTemperatureUnit() => '°C';
  String getHumidityUnit() => '%';

  String getLightStatus() {
    if (lightIntensity < 300) return 'Dark';
    if (lightIntensity < 600) return 'Dim';
    return 'Bright';
  }

  Future<void> updateMode(int mode) async {
    try {
      await _firebaseService.updateMode(mode);
      currentMode = mode;
      notifyListeners();
    } catch (e) {
      print('Error updating mode: $e');
    }
  }

  Future<void> toggleStatus(bool isAutomatic) async {
    try {
      await _firebaseService.updateStatus(isAutomatic);
      _isAutomaticMode = isAutomatic;
      notifyListeners();
    } catch (e) {
      print("Error updating status: $e");
    }
  }

  void onControlButtonTap() {
    if (_isAutomaticMode) {
      _snackbarService.showSnackbar(
          message: "You're in automatic mode. Change to manual mode to access controls",
          duration: Duration(seconds: 5));
    } else {
      _navigationService.navigateTo(Routes.controlView);
    }
  }

  void onTap() {
    _navigationService.navigateTo(Routes.helpView);
  }
}