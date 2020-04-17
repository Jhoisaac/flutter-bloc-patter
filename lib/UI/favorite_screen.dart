import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/favorite_bloc.dart';
import 'package:restaurant_finder/UI/restaurant_tile.dart';

import '../DataLayer/restaurant.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('\n******************************************************************');
    print('13 FavoriteScreen:StatelessWidget -> build() ${context.hashCode}');
    print('******************************************************************');

    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamBuilder<List<Restaurant>>(
        stream: bloc.favoritesStream,
        // 1
        initialData: bloc.favorites,
        builder: (context, snapshot) {
          print('________________________________________________________________________');
          print('28 FavoriteScreen:StatelessWidget -> StreamBuilder() ${context.hashCode}');
          if(snapshot.data != null) { print('29 snapshot.data.length es: ${snapshot.data.length}'); }

          // 2
          List<Restaurant> favorites =
              (snapshot.connectionState == ConnectionState.waiting)
                  ? bloc.favorites
                  : snapshot.data;

          if(favorites == null || favorites.isEmpty) {
            print('30 FavoriteScreen:StatelessWidget -> No favorites! Returning :(');
            print('________________________________________________________________________');
            return Center(child: Text('No Favorites'),);
          }

          print('________________________________________________________________________');

          return ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              print('48 FavoriteScreen:StatelessWidget -> itemBuilder():$index ${context.hashCode}');

              final restaurant = favorites[index];

              return RestaurantTile(
                restaurant: restaurant,
                parentCalling: 'favorite_screen',
              );
            },
          );
        },
      ),
    );
  }
}