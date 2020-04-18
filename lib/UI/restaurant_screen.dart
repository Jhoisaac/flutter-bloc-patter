import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/restaurant_bloc.dart';
import 'package:restaurant_finder/UI/favorite_screen.dart';
import 'package:restaurant_finder/UI/location_screen.dart';
import 'package:restaurant_finder/UI/restaurant_tile.dart';

import '../DataLayer/location.dart';
import '../DataLayer/restaurant.dart';

class RestaurantScreen extends StatelessWidget {
  final Location location;

  const RestaurantScreen({Key key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('\n******************************************************************');
    print('17 RestaurantScreen:StatelessWidget -> build() ${context.hashCode}');
    print('******************************************************************');

    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () => Navigator.of(context)
                /*.push(PageRouteBuilder(opaque: false, pageBuilder: (BuildContext context, _, __) => FavoriteScreen(),)),*/
                .push(MaterialPageRoute(opaque: false, builder: (_) => FavoriteScreen(),)),
          )
        ],
      ),
      body: _buildSearch(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit_location),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            opaque: false,
            builder: (context) => LocationScreen(
              // 1
              isFullScreenDialog: true,
            ),
            fullscreenDialog: true,
            /*maintainState: true,*/
          )),
          
        /*onPressed: () => Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            fullscreenDialog: true,
            pageBuilder: ( BuildContext context, _, __ ) => LocationScreen(isFullScreenDialog: true,),
          )),*/
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    print('37 RestaurantScreen:StatelessWidget -> _buildSearch() ${context.hashCode}');

    final bloc = RestaurantBloc(location, 'restaurantBlocName');

    return BlocProvider(
      bloc: bloc,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What do you want to eat?'),
              onChanged: (query) => bloc.submitQuery(query),
            ),
          ),
          Expanded(
            child: _buildStreamBuilder(bloc),
          )
        ],
      ),
    );
  }

  Widget _buildStreamBuilder(RestaurantBloc bloc) {
    print('63 RestaurantScreen:StatelessWidget -> _buildStreamBuilder() executed!');

    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        print('________________________________________________________________________');
        print('69 RestaurantScreen:StatelessWidget -> StreamBuilder() ${context.hashCode}!');
        if(snapshot.data != null) {
          print('71 snapshot.data.length es: ${snapshot.data.length}');
        } else {
          print('71 snapshot.data.length es: ${snapshot.data}');
        }

        final results = snapshot.data;

        if(results == null) {
          print('72 results == null first time enter page -> output message -Enter a restaurant name or couisine type-');
          print('________________________________________________________________________');
          return Center(child: Text('Enter a restaurant name or couisine type'),);
        }

        if(results.isEmpty) {
          print('72 results.isEmpty -> No Results found!');
          print('________________________________________________________________________');
          return Center(child: Text('No Results'),);
        }

        print('________________________________________________________________________');

        return _buildSearchResults(results);
      }
    );
  }

  Widget _buildSearchResults(List<Restaurant> results) {
    print('\n98 RestaurantScreen:StatelessWidget -> _buildSearchResults() executed!');
    
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        print('\n------------------------------------------------------------------');
        print('105 RestaurantScreen:StatelessWidget -> itemBuilder():$index ${context.hashCode}');

        final restaurant = results[index];
        print('108 RestaurantScreen:StatelessWidget -> itemBuilder():restaurant.id(${restaurant.id}) ${context.hashCode}');
        print('109 RestaurantScreen:StatelessWidget -> itemBuilder():restaurant.name(${restaurant.name}) ${context.hashCode}');
        return RestaurantTile(restaurant: restaurant, parentCalling: 'restaurant_screen',);
      },
    );
  }
}