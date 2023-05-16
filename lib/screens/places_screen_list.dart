import 'package:flutter/material.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlaceScreenList extends StatelessWidget {
  const PlaceScreenList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.place_form);
            },
            icon: const Icon(Icons.add))
      ], title: const Text('Meus Lugares')),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('Nenhum Lugar Cadastrado'),
                ),
                builder: (context, greatPlaces, ch) => greatPlaces.itemsCount ==
                        0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: ((context, index) => ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  AppRoutes.place_detail,
                                  arguments: greatPlaces.itemByIndex(index));
                            },
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                  greatPlaces.itemByIndex(index).image),
                            ),
                            title: Text(greatPlaces.itemByIndex(index).title),
                            subtitle: Text(greatPlaces
                                .itemByIndex(index)
                                .location!
                                .address
                                .toString())))),
              ),
      ),
    );
  }
}
