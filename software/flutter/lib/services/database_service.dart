import 'package:firebase_database/firebase_database.dart';

final dbcode = "uxCwM1edkQgSqE7NTtIo0gzEHJY2";

class DatabaseService {
  final _dbref = FirebaseDatabase.instance.ref();
  Future<void> updateAtomizerStatus(bool status) async {
    try {
      await _dbref.child('devices/$dbcode/data/atomizer').set(status);
    } catch (e) {
      throw Exception("Failed to update atomizer status: $e");
    }
  }

  // Update Light Intensity
  Future<void> updateLightIntensity(int value) async {
    try {
      await _dbref.child('devices/$dbcode/data/light').set(value);
    } catch (e) {
      throw Exception("Failed to update light intensity: $e");
    }
  }

  // Update Pelter Status
  Future<void> updatePelterStatus(bool status) async {
    try {
      await _dbref.child('devices/$dbcode/data/pelter').set(status);
    } catch (e) {
      throw Exception("Failed to update pelter status: $e");
    }
  }
  // Update Humidity Status
  Future<void> updateHumidityStatus(bool status) async {
    try {
      await _dbref.child('devices/$dbcode/data/humidity').set(status);
    } catch (e) {
      throw Exception("Failed to update humidity status: $e");
    }
  }

  // Fetch Atomizer Status
  Future<bool> getAtomizerStatus() async {
    try {
      final snapshot =
          await _dbref.child('devices/$dbcode/data/atomizer').get();
      if (snapshot.exists) {
        return snapshot.value as bool;
      } else {
        return false; // Default value
      }
    } catch (e) {
      throw Exception("Failed to fetch atomizer status: $e");
    }
  }

  // Fetch Light Intensity
  Future<int> getLightIntensity() async {
    try {
      final snapshot = await _dbref.child('devices/$dbcode/data/light').get();
      if (snapshot.exists) {
        return snapshot.value as int;
      } else {
        return 0; // Default value
      }
    } catch (e) {
      throw Exception("Failed to fetch light intensity: $e");
    }
  }

  // Fetch Pelter Status
  Future<bool> getPelterStatus() async {
    try {
      final snapshot = await _dbref.child('devices/$dbcode/data/pelter').get();
      if (snapshot.exists) {
        return snapshot.value as bool;
      } else {
        return false; // Default value
      }
    } catch (e) {
      throw Exception("Failed to fetch pelter status: $e");
    }
  }

  Future<bool> getHumidityStatus() async {
    try {
      final snapshot = await _dbref.child('devices/$dbcode/data/humidity').get();
      if (snapshot.exists) {
        return snapshot.value as bool;
      } else {
        return false; // Default value
      }
    } catch (e) {
      throw Exception("Failed to fetch hummidity status: $e");
    }
  }
}
