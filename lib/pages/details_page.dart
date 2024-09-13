import 'package:flutter/material.dart';

class PlanetDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic planet = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(planet['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              planet['name'],
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.network(
              planet['image'],
              height: 250,
              width: 250,
            ),
            const SizedBox(height: 10),
            Text(
              planet['description'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Distance from the earth: ${planet['distance']} km'),
            Text('Size of ${planet['name']} ${planet['size']}'),
          ],
        ),
      ),
    );
  }
}
