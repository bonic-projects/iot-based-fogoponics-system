import 'package:flutter/material.dart';
import 'package:fogoponics_system/ui/views/help/help_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HelpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelpViewModel>.reactive(
      viewModelBuilder: () => HelpViewModel(),
      builder: (context, model, child) {
        // Group plants by category
        final plantsByCategory = model.plantsByCategory;

        return Scaffold(
          appBar: AppBar(
            title: Text('Plants'),
          ),
          body: ListView(
            children: plantsByCategory.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Heading
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      entry.key, // Category name
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Customize as needed
                      ),
                    ),
                  ),
                  // Plants under this category
                  ...entry.value.map((plant) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: Image.asset(
                          plant.imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          plant.name,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('pH Range: ${plant.pHRange}'),
                            Text('TDS Range: ${plant.tdsRange}'),
                            Text('Nutrient Requirement: ${plant.nutrientRequirement}'),
                            Text('Temperature: ${plant.temperature}'),
                            Text('Humidity: ${plant.humidity}'),
                            Text('Fogger Cycle: ${plant.foggerCycle}'),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}