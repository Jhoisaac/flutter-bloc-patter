import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';
import 'package:restaurant_finder/UI/location_screen.dart';
import 'package:restaurant_finder/UI/restaurant_screen.dart';

import '../DataLayer/location.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('\n******************************************************************');
    print('12 MainScreen:StatelessWidget -> build() ${context.hashCode}');
    print('******************************************************************');

    return StreamBuilder<Location>(
      // 1
      stream: BlocProvider.of<LocationBloc>(context).locationStream,
      initialData: null,
      builder: (context, snapshot) {
        print('________________________________________________________________________');
        print('21 MainScreen:StatelessWidget -> StreamBuilder() ${context.hashCode}');
        print('22 MainScreen:StatelessWidget -> snapshot.data ${snapshot.data}');
        
        final location = snapshot.data;

        // 2
        if(location == null) {          
          print('________________________________________________________________________');
          print('\n***LocationScreen() executing!***');

          return const LocationScreen();
        }
        
        print('23 MainScreen:StatelessWidget -> location.id ${location.id}');
        print('24 MainScreen:StatelessWidget -> location.title ${location.title}');
        print('25 MainScreen:StatelessWidget -> location.type ${location.type}');
        print('________________________________________________________________________');
        print('\n***RestaurantScreen() executing!***');
        
        // this will be changed this later
        return RestaurantScreen(location: location,);
      }
    );
  }
}