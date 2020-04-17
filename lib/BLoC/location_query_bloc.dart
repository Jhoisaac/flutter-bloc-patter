import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';

import '../DataLayer/location.dart';
import '../DataLayer/zomato_client.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();
  Stream<List<Location>> get locationStream => _controller.stream;

  final String name;

  LocationQueryBloc({this.name});

  void submitQuery(String query) async {
    print('\n18 LocationQueryBloc:Bloc -> submitQuery($query)');
    // 1
    print('20 LocationQueryBloc:Bloc -> ANTES await _client.fetchLocations($query);');
    final results = await _client.fetchLocations(query);
    print('22 LocationQueryBloc:Bloc -> DESPUES await _client.fetchLocations($query);');
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    print('\n28 LocationQueryBloc:Bloc -> dispose() executed!');
    _controller.close();
  }

  @override
  String get nameTypeBloc => name;
}