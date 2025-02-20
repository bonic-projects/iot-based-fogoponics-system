import 'package:stacked/stacked.dart';
import '../models/plant_data.dart';

class PlantService with ReactiveServiceMixin {
  List<Plant> _plants = [];
  List<Plant> get plants => _plants;

  PlantService() {
    // Initialize the data
    _plants = [
      // fruit-bearing plants
      Plant(
        name: 'Strawberries',
        pHRange: '5.5--6.5',
        tdsRange: '1260--1540 ppm',
        nutrientRequirement: '10-10-20',
        temperature: '18--24 °C',
        humidity: '70--80%',
        foggerCycle: '40 sec ON, 5 min OFF',
        imagePath: 'assets/strawberries.png',
        category: 'Fruit-Bearing Plants',
      ),
      Plant(
        name: 'Tomatoes',
        pHRange: '5.5--6.5',
        tdsRange: '1400--3500 ppm',
        nutrientRequirement: '5-15-45',
        temperature: '20--26 °C',
        humidity: '50--70%',
        foggerCycle: '50 sec ON, 6 min OFF',
        imagePath: 'assets/tomatos.png',
        category: 'Fruit-Bearing Plants',
      ),
      Plant(
        name: 'Bell Peppers',
        pHRange: '5.5--6.5',
        tdsRange: '1400--2100 ppm',
        nutrientRequirement: '10-5-20',
        temperature: '18--26 °C',
        humidity: '50--70%',
        foggerCycle: '40 sec ON, 5 min OFF',
        imagePath: 'assets/bell.png',
        category: 'Fruit-Bearing Plants',
      ),
      Plant(
        name: 'Cucumbers',
        pHRange: '5.5--6.0',
        tdsRange: '1120--1750 ppm',
        nutrientRequirement: '8-16-36',
        temperature: '22--26 °C',
        humidity: '60--80%',
        foggerCycle: '50 sec ON, 6 min OFF',
        imagePath: 'assets/cucumber.png',
        category: 'Fruit-Bearing Plants',
      ),
      //herbs
    Plant(name: 'Basil',
        pHRange: '5.5-6.5',
        tdsRange: '700-1120',
        nutrientRequirement: '10-5-20',
        temperature: '20-25',
        humidity: '40-60',
        foggerCycle: '30 sec ON,4 min OFF',
        imagePath: 'assets/basil.png',
      category: 'Herbs',
    ),
      Plant(name: 'Mint',
          pHRange: '6.0-7.0',
          tdsRange: '800-1500',
          nutrientRequirement: '12-12-12', 
          temperature: '18-22',
          humidity: '50-70',
          foggerCycle: '40 sec ON,6 min OFF',
          imagePath: 'assets/mint.png', category: 'Herbs',
      ),
      Plant(name: 'Cilantro', pHRange: '6.5-7.5', tdsRange: '800-1500',
          nutrientRequirement: '10-10-10', temperature: '16-21', humidity: '40-50', foggerCycle: '30 sec ON,5 min OFF',
          imagePath: 'assets/cilantro.png', category: 'Herbs',),
      Plant(name: 'Parsely', pHRange:'6.0-7.0', tdsRange: '800-1500', nutrientRequirement: '5-10-10', temperature: '18-24',
          humidity: '50-70', foggerCycle: '30 sec ON,4 min OFF', imagePath: 'assets/parsley.png', category: 'Herbs',),
      Plant(name: 'Thyme', pHRange: '5.5-7.0', tdsRange: '800-1200', nutrientRequirement: '5-10-5', temperature: '16-22', humidity: '40-60', foggerCycle: '20 sec ON,5 min OFF',
          imagePath: 'assets/thyme.png', category: 'Herbs',),
      //leafy green plants
      Plant(name: 'Lettuce', pHRange: '5.5-6.5', tdsRange: '560-840', nutrientRequirement: '8-15-36', temperature: '18-24', humidity: '50-70', foggerCycle: '30 sec ON,4 min OFF',
          imagePath: 'assets/lettuce.png', category: 'Leafy Green Plants',),
      Plant(name: 'Spinach', pHRange: '6.0-7.0', tdsRange: '900-1200', nutrientRequirement: '10-5-14', temperature: '16-22', humidity: '60-80', foggerCycle: '45 sec ON,5 min OFF',
          imagePath: 'assets/spinach.png', category: 'Leafy Green Plants',),
      Plant(name: 'Kale', pHRange: '5.5-6.5', tdsRange: '800-1200', nutrientRequirement: '9-5-14', temperature: '15-20', humidity: '50-70', foggerCycle: '40 sec ON,4 min OFF',
          imagePath: 'assets/kale.png', category: 'Leafy Green Plants',),
      Plant(name: 'Swiss Chard', pHRange: '6.0-6.5', tdsRange: '800-1000', nutrientRequirement: '8-15-36', temperature: '18-24', humidity: '60-70', foggerCycle: '35 sec ON,4 min OFF',
          imagePath: 'assets/swiss.png',category: 'Leafy Green Plants'),
      Plant(name: 'Bok Choy', pHRange: '6.0-7.5', tdsRange: '800-1600', nutrientRequirement: '8-16-36', temperature: '18-24', humidity: '50-70', foggerCycle: '20 sec ON,5 min OFF',
          imagePath: 'assets/bok choy.png',category: 'Leafy Green Plants'),
      // microgreen and sprouts
      Plant(name: 'Broccoli Microgreens', pHRange: '5.5-6.5', tdsRange: '400-600', nutrientRequirement: '9-7-37', temperature: '18-22', humidity: '50-70', foggerCycle: '20 sec ON,4 min OFF',
          imagePath: 'assets/broccoli.png',category: 'Microgreen and Products'),
      Plant(name: 'Radish Microgreens', pHRange: '5.5-6.0', tdsRange: '400-600', nutrientRequirement: '10-5-15', temperature: '18-22', humidity: '50-70', foggerCycle: '25 sec ON,4 min OFF',
          imagePath: 'assets/radish.png',category: 'Microgreen and Products'),
      Plant(name: 'Alfalfa Sprouts', pHRange: '6.0-6.5', tdsRange: '500-700', nutrientRequirement: '9-5-14', temperature: '18-24', humidity: '50-70', foggerCycle: '15 sec ON,3 min OFF',
          imagePath: 'assets/alfalfa.png',category: 'Microgreen and Products'),
      Plant(name: 'Mustard Greens', pHRange: '6.0-6-5', tdsRange: '600-800', nutrientRequirement: '8-16-36', temperature: '20-24', humidity: '50-70', foggerCycle: '25 sec ON,4 min OFF',
          imagePath: 'assets/mustard.png',category: 'Microgreen and Products'),
      Plant(name: 'Sunflower Microgreens', pHRange: '6.0-6.5', tdsRange: '400-600', nutrientRequirement: '9-7-37', temperature: '18-22', humidity: '50-70', foggerCycle: '20 sec ON,4 min OFF',
          imagePath: 'assets/sunflower.png',category: 'Microgreen and Products'),
      // medicinal plant
      Plant(name: 'Aloe Vera', pHRange: '6.0-7.0', tdsRange: '800-1500', nutrientRequirement: '10-40-10', temperature: '18-30', humidity: '40-60', foggerCycle: '20 sec ON,5 min OFF',
          imagePath: 'assets/alovera.png',category: 'Medicinal Plant'),
      Plant(name: 'Tulsi(Holy Basil)', pHRange: '5.5-6.5', tdsRange: '800-1200', nutrientRequirement: '10-5-20', temperature: '20-25', humidity: '50-70', foggerCycle: '30 sec ON,4 min OFF',
          imagePath: 'assets/tulasi.png',category: 'Medicinal Plant'),
      Plant(name: 'Lavender', pHRange: '6.5-7.5', tdsRange: '1000-1200', nutrientRequirement: '20-20-20', temperature: '18-24', humidity: '40-60', foggerCycle: '25 sec ON,5 min OFF',
          imagePath: 'assets/lavender.png',category: 'Medicinal Plant'),
      Plant(name: 'Chamomile', pHRange: '5.6-7.5', tdsRange: '800-1000', nutrientRequirement: '10-30-10', temperature: '18-25', humidity: '50-70', foggerCycle: '30 sec ON,5 min OFF',
          imagePath: 'assets/chammoli.png',category: 'Medicinal Plant'),

    ];
    notifyListeners();
  }
  Map<String, List<Plant>> get plantsByCategory {
    Map<String, List<Plant>> groupedPlants = {};
    for (var plant in _plants) {
      groupedPlants.putIfAbsent(plant.category, () => []).add(plant);
    }
    return groupedPlants;
  }
}