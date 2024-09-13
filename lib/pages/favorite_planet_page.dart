import 'package:flutter/material.dart';

class FavoritePlanetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> favoritePlanets =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Planets'),
      ),
      body: favoritePlanets.isEmpty
          ? const Center(
              child: Text('No favorite planets yet!'),
            )
          : ListView.builder(
              itemCount: favoritePlanets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favoritePlanets[index]['name']),
                  subtitle: Text(
                      'Distance: ${favoritePlanets[index]['distance']}, Size: ${favoritePlanets[index]['size']}'),
                  leading: Image.network(favoritePlanets[index]['image']),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'detail',
                      arguments: favoritePlanets[index],
                    );
                  },
                );
              },
            ),
    );
  }
}
