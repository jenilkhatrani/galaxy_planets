import 'package:flutter/material.dart';
import 'package:galaxy_planets/Pages/home_page.dart';
import 'package:galaxy_planets/Pages/splash_page.dart';
import 'package:galaxy_planets/Provider/connectivity_provider.dart';
import 'package:galaxy_planets/Provider/theme_provider.dart';
import 'package:galaxy_planets/pages/details_page.dart';
import 'package:galaxy_planets/pages/favorite_planet_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ConnectvityProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:
          (Provider.of<ThemeProvider>(context).themeModel.isdark == false)
              ? ThemeMode.dark
              : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        '/': (context) => const HomePage(),
        'splash': (context) => const SplashScreen(),
        'detail': (context) => PlanetDetailPage(),
        'favorite': (context) => FavoritePlanetsPage(),
      },
    );
  }
}
