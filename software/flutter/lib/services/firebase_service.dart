import 'package:firebase_database/firebase_database.dart';

import '../models/device_data.dart';

final dbcode = 'uxCwM1edkQgSqE7NTtIo0gzEHJY2';

class FirebaseService {
  final _dbref = FirebaseDatabase.instance.ref();

  Future<List<DeviceReading>> getDeviceReadings() async {
    try {
      final snapshot = await _dbref.child('devices/$dbcode/reading').get();
      if (snapshot.exists) {
        final data = snapshot.value;

        print("Fetched Data: $data"); // Debugging output

        if (data is Map<dynamic, dynamic>) {
          if (data.containsKey("temperature") && data.containsKey("humidity") && data.containsKey("light")) {
            return [DeviceReading.fromMap(data)];
          } else {
            throw Exception("Missing required fields in Firebase data.");
          }
        } else {
          throw Exception("Unexpected data type: ${data.runtimeType}");
        }
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Failed to fetch device readings: $e");
    }
  }

  Future<void> updateStatus(bool isAutomatic) async {
    try {
      await _dbref.child('devices/$dbcode/data/automatic').set(isAutomatic);
    } catch (e) {
      throw Exception("Failed to update status: $e");
    }
  }

  // Fetch the current status from Firebase
  Future<bool> getStatus() async {
    try {
      final snapshot =
          await _dbref.child('devices/$dbcode/data/automatic').get();
      if (snapshot.exists) {
        return snapshot.value as bool;
      } else {
        return false; // Default value if status doesn't exist
      }
    } catch (e) {
      throw Exception("Failed to fetch status: $e");
    }
  }

  Future<void> updateMode(int mode) async {  // Changed from bool to int
    try {
      if (mode != 0 && mode != 1) {
        throw Exception("Mode must be either 0 or 1");
      }
      await _dbref.child('devices/$dbcode/data/mode').set(mode);
    } catch (e) {
      throw Exception("Failed to update status: $e");
    }
  }

  Future<int> getMode() async {  // Changed return type from bool to int
    try {
      final snapshot =
      await _dbref.child('devices/$dbcode/data/mode').get();
      if (snapshot.exists) {
        // Convert the value to int
        if (snapshot.value is bool) {
          // Handle existing boolean values in database
          return (snapshot.value as bool) ? 1 : 0;
        }
        return snapshot.value as int;
      } else {
        return 0;  // Default value if status doesn't exist
      }
    } catch (e) {
      throw Exception("Failed to fetch status: $e");
    }
  }
}
