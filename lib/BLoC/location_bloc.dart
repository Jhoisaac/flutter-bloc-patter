import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';

import '../DataLayer/location.dart';

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;

  final String name;

  // 1
  final _locationController = StreamController<Location>();

  // 2
  Stream<Location> get locationStream => _locationController.stream;

  LocationBloc({this.name});  

  // 3
  void selectLocation(Location location) {
    print('\n23 LocationBloc:Bloc -> selectLocation()');

    _location = location;
    _locationController.sink.add(location);
  }

  // 4
   @override
  void dispose() {
    print('\n32 selectLocation:Bloc -> dispose() executed!');
    _locationController.close();
  }

  @override
  String get nameTypeBloc => name;
}