import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/favorite_bloc.dart';
import 'package:restaurant_finder/UI/next_screen.dart';

import '../DataLayer/restaurant.dart';
import 'image_container.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('\n******************************************************************');
    print('16 RestaurantDetailsScreen:StatelessWidget -> build() ${context.hashCode}');
    print('******************************************************************');

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildBanner(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  restaurant.cuisines,
                  style: textTheme.subtitle.copyWith(fontSize: 18),
                ),
                Text(
                  restaurant.address,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                )
              ],
            ),
          ),
          _buildDetails(context),
          _buildFavoriteButton(context),
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: ( BuildContext context, _, __ ) => 
                      NextScreen()
                )
              );

              /*Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      NextScreen()
                )
              );*/
            },
            textColor: Theme.of(context).accentColor,
            icon: Icon(Icons.arrow_forward),
            label: Text('PushPage'),
          )
        ],
      ),
    );
  }

  Widget _buildBanner() {
    print('52 RestaurantDetailsScreen:StatelessWidget -> _buildBanner() executed!');

    return ImageContainer(
      height: 185,
      url: restaurant.imageUrl,
    );
  }

  Widget _buildDetails(BuildContext context) {
    print('61 RestaurantDetailsScreen:StatelessWidget -> _buildDetails() ${context.hashCode}');

    final style = const TextStyle(fontSize: 16);

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price: ${restaurant.priceDisplay}',
            style: style,
          ),
          SizedBox(width: 40,),
          Text(
            'Rating: ${restaurant.rating.average}',
            style: style,
          )
        ],
      ),
    );
  }

  // 1
  Widget _buildFavoriteButton(BuildContext context) {
    print('86 RestaurantDetailsScreen:StatelessWidget -> _buildFavoriteButton() ${context.hashCode}');

    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return StreamBuilder<List<Restaurant>>(
      stream: bloc.favoritesStream,
      initialData: bloc.favorites,
      builder: (context, snapshot) {
        print('________________________________________________________________________');
        print('95 RestaurantDetailsScreen:StatelessWidget -> StreamBuilder() ${context.hashCode}');
        if(snapshot.data != null) {
          print('97 snapshot.data.length es: ${snapshot.data.length}');
        } else {
          print('99 snapshot.data.length es: ${snapshot.data}');
        }

        print("(snapshot.connectionState(${snapshot.connectionState}) == ConnectionState.waiting(${ConnectionState.waiting})) es: ${snapshot.connectionState == ConnectionState.waiting}");
        if((snapshot.connectionState == ConnectionState.waiting)) {
           print("favorites = bloc.favorites es: ${bloc.favorites}}");
        } else {
           print("favorites = snapshot.data es: ${snapshot.data}");
        }

        print('________________________________________________________________________');

        List<Restaurant> favorites =
            (snapshot.connectionState == ConnectionState.waiting)
                ? bloc.favorites
                : snapshot.data;

        bool isFavorite = favorites.contains(restaurant);

        return FlatButton.icon(
          // 2
          onPressed: () => bloc.toggleRestaurant(restaurant),
          textColor: isFavorite ? Theme.of(context).accentColor : null,
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          label: Text('Favorite'),
        );
      },
    );
  }
}