import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_planets/Provider/connectivity_provider.dart';
import 'package:galaxy_planets/Provider/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<dynamic> planets = [];
  Set<dynamic> favoritePlanets = {};
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    loadJsonData();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animationController.repeat();

    Provider.of<ConnectvityProvider>(context, listen: false)
        .checkConnectivity();
  }

  Future<void> loadJsonData() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/planet.json');
    final data = jsonDecode(jsonString);
    setState(() {
      planets = data;
    });
  }

  void toggleFavorite(dynamic planet) {
    setState(() {
      if (favoritePlanets.remove(planet)) {
      } else {
        favoritePlanets.add(planet);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Provider.of<ConnectvityProvider>(context)
                .connectivityModel
                .isInternet ==
            false)
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'No Internet',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          )
        : DefaultTabController(
            length: 9, // 9 tabs for 9 planets
            child: Scaffold(
                drawer: Drawer(
                  width: 220,
                  child: Column(
                    children: [
                      const DrawerHeader(
                        child: Center(
                          child: Text(
                            'Galaxy Planets',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Dark Theme'),
                          const Spacer(),
                          Switch(
                            value: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isdark ==
                                false),
                            onChanged: (value) {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .theme();
                            },
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            'favorite',
                            arguments: favoritePlanets.toList(),
                          );
                        },
                        child: const Text('Favorites'),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  title: const Text('Planets'),
                  bottom: const TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(child: Text('Mercury')),
                      Tab(child: Text('Venus')),
                      Tab(child: Text('Earth')),
                      Tab(child: Text('Mars')),
                      Tab(child: Text('Jupiter')),
                      Tab(child: Text('Saturn')),
                      Tab(child: Text('Uranus')),
                      Tab(child: Text('Neptune')),
                      Tab(child: Text('Sun')),
                    ],
                  ),
                ),
                body: planets.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : TabBarView(
                        children: List.generate(9, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  planets[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                RotationTransition(
                                  turns: animationController,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        'detail',
                                        arguments: planets[index],
                                      );
                                    },
                                    child: Image.network(
                                      planets[index]['image'],
                                      height: 250,
                                      width: 250,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Distance from the earth: ${planets[index]['distance']} ',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Size of ${planets[index]['name']} ${planets[index]['size']}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 50),
                                IconButton(
                                  onPressed: () {
                                    toggleFavorite(planets[index]);
                                  },
                                  icon: Icon(
                                    favoritePlanets.contains(planets[index])
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
          );
  }
}

//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   List<dynamic> planets = [];
//   late AnimationController animationController;
//   late TabController _tabController;
//   late PageController _pageController;
//
//   @override
//   void initState() {
//     super.initState();
//     loadJsonData();
//
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );
//     animationController.repeat();
//
//     // Initialize TabController and PageController
//     _tabController = TabController(length: 9, vsync: this);
//     _pageController = PageController();
//
//     // Listen to tab changes and update page
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         _pageController.animateToPage(
//           _tabController.index,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.ease,
//         );
//       }
//     });
//
//     // Check connectivity at initialization
//     Provider.of<ConnectvityProvider>(context, listen: false)
//         .checkConnectivity();
//   }
//
//   Future<void> loadJsonData() async {
//     final String jsonString = await rootBundle
//         .loadString('assets/json/planet.json'); // Load JSON from assets
//     final data = jsonDecode(jsonString);
//     setState(() {
//       planets = data;
//     });
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     _tabController.dispose();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   void openPlanetDetail(int index) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PlanetDetailPage(
//           planet: planets[index],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return (Provider.of<ConnectvityProvider>(context)
//                 .connectivityModel
//                 .isInternet ==
//             false)
//         ? const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.wifi_off_outlined,
//                       color: Colors.grey,
//                       size: 30,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       'No Internet',
//                       style: TextStyle(
//                           decoration: TextDecoration.none,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         : DefaultTabController(
//             length: 9,
//             child: Scaffold(
//               drawer: Drawer(
//                 width: 220,
//                 child: Column(
//                   children: [
//                     const DrawerHeader(
//                         child: Center(
//                       child: Text(
//                         'Galaxy Planets',
//                         style: TextStyle(
//                             fontSize: 25, fontWeight: FontWeight.bold),
//                       ),
//                     )),
//                     Row(
//                       children: [
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         const Text('Dark Theme'),
//                         const Spacer(),
//                         Switch(
//                             value: (Provider.of<ThemeProvider>(context)
//                                     .themeModel
//                                     .isdark ==
//                                 false),
//                             onChanged: (value) {
//                               Provider.of<ThemeProvider>(context, listen: false)
//                                   .theme();
//                             }),
//                       ],
//                     ),
//                     TextButton(onPressed: () {}, child: const Text('Favourite'))
//                   ],
//                 ),
//               ),
//               appBar: AppBar(
//                 title: const Text('Planets'),
//                 bottom: TabBar(
//                   controller: _tabController,
//                   isScrollable: true,
//                   tabs: const [
//                     Tab(child: Text('Mercury')),
//                     Tab(child: Text('Venus')),
//                     Tab(child: Text('Earth')),
//                     Tab(child: Text('Mars')),
//                     Tab(child: Text('Jupiter')),
//                     Tab(child: Text('Saturn')),
//                     Tab(child: Text('Uranus')),
//                     Tab(child: Text('Neptune')),
//                     Tab(child: Text('Sun')),
//                   ],
//                 ),
//               ),
//               body: planets.isEmpty
//                   ? const Center(child: CircularProgressIndicator())
//                   : PageView.builder(
//                       controller: _pageController,
//                       onPageChanged: (index) {
//                         _tabController.animateTo(index);
//                       },
//                       itemCount: planets.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 planets[index]['name'],
//                                 style: const TextStyle(
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               GestureDetector(
//                                 onTap: () {
//                                   openPlanetDetail(index);
//                                 },
//                                 child: RotationTransition(
//                                   turns: animationController,
//                                   child: Image.network(
//                                     planets[index]['image'],
//                                     height: 250,
//                                     width: 250,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(planets[index]['description']),
//                               const SizedBox(height: 10),
//                               Text(
//                                   'Distance from the earth: ${planets[index]['distance']} km'),
//                               Text(
//                                   'Size of ${planets[index]['name']} ${planets[index]['size']}'),
//                               IconButton(
//                                   onPressed: () {},
//                                   icon: const Icon(Icons.favorite_border))
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           );
//   }
// }
//
// class PlanetDetailPage extends StatelessWidget {
//   final dynamic planet;
//   const PlanetDetailPage({super.key, required this.planet});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(planet['name']),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               planet['name'],
//               style: const TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Image.network(
//               planet['image'],
//               height: 250,
//               width: 250,
//             ),
//             const SizedBox(height: 10),
//             Text(planet['description']),
//             const SizedBox(height: 10),
//             Text('Distance from the earth: ${planet['distance']} km'),
//             Text('Size of ${planet['name']} ${planet['size']}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
