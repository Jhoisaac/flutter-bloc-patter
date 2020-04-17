import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';

import '../DataLayer/restaurant.dart';

class FavoriteBloc implements Bloc {
  var _restaurants = <Restaurant>[];
  List<Restaurant> get favorites => _restaurants;

  final String name;

  // 1
  final _controller = StreamController<List<Restaurant>>.broadcast();
  Stream<List<Restaurant>> get favoritesStream => _controller.stream;

  FavoriteBloc(this.name);

  void toggleRestaurant(Restaurant restaurant) {
    print('\n20 toggleRestaurant:Bloc -> selectLocation()');

    if(_restaurants.contains(restaurant)) {
      _restaurants.remove(restaurant);

    } else {
      _restaurants.add(restaurant);
    }

    _controller.sink.add(_restaurants);
  }

  @override
  void dispose() {
    print('\n34 FavoriteBloc:Bloc -> dispose() executed!');
    _controller.close();
  }

  @override
  String get nameTypeBloc => name;
}