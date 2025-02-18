import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../services/firebase_service.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Sensor Dashboard'),
          elevation: 0,
          actions: [
            // Toggle Switch
            Switch(
              value: model.isAutomaticMode,
              onChanged: (value) => model.toggleStatus(value),
              activeColor: Colors.green,
            ),
          ],
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Temperature Card
                    _buildSensorCard(
                      icon: Icons.thermostat,
                      title: 'Temperature',
                      value: model.temperature.toStringAsFixed(1),
                      unit: model.getTemperatureUnit(),
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 16),

                    // Humidity Card
                    _buildSensorCard(
                      icon: Icons.water_drop,
                      title: 'Humidity',
                      value: model.humidity.toStringAsFixed(1),
                      unit: model.getHumidityUnit(),
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),

                    // Light Intensity Card
                    _buildSensorCard(
                      icon: Icons.light_mode,
                      title: 'Light Intensity',
                      value: model.lightIntensity.toStringAsFixed(0),
                      unit: model.getLightStatus(),
                      color: Colors.yellow.shade800,
                    ),
                    // SizedBox(
                    //   height: 300,
                    // ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => model.updateMode(0),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: model.currentMode == 0
                                  ? Colors.orange
                                  : Colors.grey,
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: Icon(Icons.whatshot, color: Colors.white),
                            label: Text(
                              'Hot Mode',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton.icon(
                            onPressed: () => model.updateMode(1),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: model.currentMode == 1
                                  ? Colors.blue
                                  : Colors.grey,
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: Icon(Icons.ac_unit, color: Colors.white),
                            label: Text(
                              'Cool Mode',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: Row(
          children: [
            Padding(padding: EdgeInsets.all(16)),
            FloatingActionButton.extended(
              onPressed: () => model.onTap(),
              backgroundColor: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              label: Row(
                children: [Text('Help'), Icon(Icons.help_rounded)],
              ),
            ),
            SizedBox(
              width: 120,
            ),
            FloatingActionButton.extended(
              onPressed: () => model.onControlButtonTap(),
              backgroundColor: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              label: Row(
                children: [Text('Control'), Icon(Icons.cached_outlined)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard({
    required IconData icon,
    required String title,
    required String value,
    required String unit,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        unit,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
