import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';

import '../DataLayer/location.dart';
import '../DataLayer/restaurant.dart';
import '../DataLayer/zomato_client.dart';

class RestaurantBloc implements Bloc {
  final Location location;
  final _client = ZomatoClient();
  final _controller = StreamController<List<Restaurant>>();

  final String _name;

  Stream<List<Restaurant>> get stream => _controller.stream;
  RestaurantBloc(this.location, this._name);
  
  void submitQuery(String query) async{
    print('\n20 RestaurantBloc:Bloc -> submitQuery($query)');

    print('22 RestaurantBloc:Bloc -> ANTES await _client.fetchRestaurants($query);');
    final results = await _client.fetchRestaurants(location, query);
    print('24 RestaurantBloc:Bloc -> DESPUES await _client.fetchRestaurants($query);');
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    print('\n30 RestaurantBloc:Bloc -> dispose() executed!');
    _controller.close();
  }

  @override
  String get nameTypeBloc => _name;

}