class Plant {
  final String name;
  final String pHRange;
  final String tdsRange;
  final String nutrientRequirement;
  final String temperature;
  final String humidity;
  final String foggerCycle;
  final String imagePath;
  final String category;

  Plant({
    required this.name,
    required this.pHRange,
    required this.tdsRange,
    required this.nutrientRequirement,
    required this.temperature,
    required this.humidity,
    required this.foggerCycle,
    required this.imagePath,
    required this.category,
  });
}
