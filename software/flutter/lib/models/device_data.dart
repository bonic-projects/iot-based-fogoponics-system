class DeviceReading {
  final double temperature;
  final double humidity;
  final double light;
  final String timestamp;  // If ts is expected as a String, ensure handling

  DeviceReading({
    required this.temperature,
    required this.humidity,
    required this.light,
    required this.timestamp,
  });

  factory DeviceReading.fromMap(Map<dynamic, dynamic> map) {
    return DeviceReading(
      temperature: (map['temperature'] ?? 0.0).toDouble(), // Handle null
      humidity: (map['humidity'] ?? 0.0).toDouble(),
      light: (map['light'] ?? 0.0).toDouble(),
      timestamp: (map['ts'] ?? "").toString(), // Ensure ts is a String
    );
  }
}
