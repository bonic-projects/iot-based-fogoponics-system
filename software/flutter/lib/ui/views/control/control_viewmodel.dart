import 'package:fogoponics_system/services/database_service.dart';
import 'package:fogoponics_system/services/firebase_service.dart';
import 'package:stacked/stacked.dart';

class ControlViewModel extends BaseViewModel {
  final DatabaseService _databaseService;

  bool _atomizerStatus = false;
  bool get atomizerStatus => _atomizerStatus;

  int _lightIntensity = 0;
  int get lightIntensity => _lightIntensity;

  bool _pelterStatus = false;
  bool get pelterStatus => _pelterStatus;

  bool _humidityStatus =false;
  bool get humidityStatus => _humidityStatus;

  ControlViewModel({required DatabaseService databaseService})
      : _databaseService = databaseService;

  Future<void> init() async {
    setBusy(true);
    try {
      _atomizerStatus = await _databaseService.getAtomizerStatus();
      _lightIntensity = await _databaseService.getLightIntensity();
      _pelterStatus = await _databaseService.getPelterStatus();
      _humidityStatus =await _databaseService.getHumidityStatus();
      notifyListeners();
    } catch (e) {
      print("Error fetching controls: $e");
    } finally {
      setBusy(false);
    }
  }

  Future<void> toggleAtomizer(bool newStatus) async {
    try {
      await _databaseService.updateAtomizerStatus(newStatus);
      _atomizerStatus = newStatus;
      notifyListeners();
    } catch (e) {
      print("Error updating atomizer status: $e");
    }
  }

  Future<void> updateLight(int newValue) async {
    try {
      await _databaseService.updateLightIntensity(newValue);
      _lightIntensity = newValue;
      notifyListeners();
    } catch (e) {
      print("Error updating light intensity: $e");
    }
  }

  Future<void> togglePelter(bool newStatus) async {
    try {
      await _databaseService.updatePelterStatus(newStatus);
      _pelterStatus = newStatus;
      notifyListeners();
    } catch (e) {
      print("Error updating pelter status: $e");
    }
  }

  Future<void> toggleHumidity(bool newStatus) async {
    try {
      await _databaseService.updateHumidityStatus(newStatus);
      _humidityStatus = newStatus;
      notifyListeners();
    } catch (e) {
      print("Error updating humidity status: $e");
    }
  }
}
