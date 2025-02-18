import 'package:stacked/stacked.dart';

import '../../../models/plant_data.dart';
import '../../../services/plant_service.dart';

class HelpViewModel extends BaseViewModel {
  final PlantService _plantService = PlantService();

  // Get all plants
  List<Plant> get plants => _plantService.plants;

  // Group plants by category
  Map<String, List<Plant>> get plantsByCategory {
    Map<String, List<Plant>> groupedPlants = {};
    for (var plant in plants) {
      groupedPlants.putIfAbsent(plant.category, () => []).add(plant);
    }
    return groupedPlants;
  }
}