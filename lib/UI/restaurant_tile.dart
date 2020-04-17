import 'package:flutter/material.dart';
import 'package:restaurant_finder/UI/restaurant_details_screen.dart';

import '../DataLayer/restaurant.dart';
import 'image_container.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;
  final String parentCalling;

  const RestaurantTile({Key key, @required this.restaurant, this.parentCalling}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('14 RestaurantTile:StatelessWidget:$parentCalling -> build() ${context.hashCode}');
    print('15 RestaurantTile:StatelessWidget:$parentCalling -> restaurant.id es: ${restaurant.id}');
    print('16 RestaurantTile:StatelessWidget:$parentCalling -> restaurant.name es: ${restaurant.name}');

    return ListTile(
      leading: ImageContainer(
        width: 50,
        height: 50,
        url: restaurant.thumbUrl,),
      title: Text(restaurant.name),      
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        print('26 RestaurantTile:StatelessWidget -> onTap() executed! ${context.hashCode}');
        print('27 RestaurantTile:StatelessWidget -> Navigator.push() entering to RestaurantDetailsScreen()');

        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: ( BuildContext context, _, __ ) => 
                RestaurantDetailsScreen(restaurant: restaurant)
          )
        );

        /*Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                RestaurantDetailsScreen(restaurant: restaurant)
          )
        );*/
      },
    );
  }
}