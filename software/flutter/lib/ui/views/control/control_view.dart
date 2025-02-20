import 'package:flutter/material.dart';
import 'package:fogoponics_system/services/database_service.dart';
import 'package:stacked/stacked.dart';
import '../../../services/firebase_service.dart';
import 'control_viewmodel.dart';

class ControlView extends StatelessWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ControlViewModel>.reactive(
      viewModelBuilder: () => ControlViewModel(
        databaseService: DatabaseService(),
      ),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Control Panel'),
          elevation: 0,
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Atomizer Toggle
                    _buildControlCard(
                      color:Colors.blue ,
                      icon: Icons.cloud,
                      title: 'Atomizer',
                      child: Switch(
                        value: model.atomizerStatus,
                        onChanged: (value) => model.toggleAtomizer(value),
                        activeColor: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Light Slider
                    _buildControlCard(
                      color: Colors.teal,
                      icon: Icons.lightbulb,
                      title: 'Light Intensity',
                      child: Column(
                        children: [
                          Slider(
                            value: model.lightIntensity.toDouble(),
                            min: 0,
                            max: 4095,
                            divisions: 4095,
                            label: model.lightIntensity.toString(),
                            onChanged: (value) =>
                                model.updateLight(value.toInt()),
                          ),
                          Text(
                            'Value: ${model.lightIntensity}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Pelter Toggle
                    _buildControlCard(
                      color: Colors.deepOrangeAccent,
                      icon: Icons.ac_unit,
                      title: 'Peltier',
                      child: Switch(
                        value: model.pelterStatus,
                        onChanged: (value) => model.togglePelter(value),
                        activeColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Humidity Toggle
                    _buildControlCard(
                      color: Colors.lightBlueAccent,
                      icon: Icons.water_drop,
                      title: 'Humidity',
                      child: Switch(
                        value: model.humidityStatus,
                        onChanged: (value) => model.toggleHumidity(value),
                        activeColor: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildControlCard({
    required IconData icon,
    required String title,
    required Widget child,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),),
                child: Icon(icon, size: 32,color: color,)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
