import 'package:flutter/material.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/screens/palce_form_screen.dart';
import 'package:greatplaces/screens/place_details.dart';
import 'package:greatplaces/screens/places_screen_list.dart';
import 'package:greatplaces/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(
      brightness: Brightness.light,
    );
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: tema.copyWith(
            colorScheme: tema.colorScheme.copyWith(
          primary: Colors.indigo,
          secondary: Colors.deepPurple,
        )),
        home: const PlaceScreenList(),
        routes: {
          AppRoutes.place_form: (context) => const PlaceFormScreen(),
          AppRoutes.place_detail: (context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
