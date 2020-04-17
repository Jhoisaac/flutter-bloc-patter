import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';
import 'package:restaurant_finder/BLoC/location_query_bloc.dart';

import '../DataLayer/location.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('\n******************************************************************');
    print('17 LocationScreen:StatelessWidget -> build() ${context.hashCode}');
    print('******************************************************************');
    // 1
    final bloc = LocationQueryBloc(name: 'locationQueryBlocName');

    // 2
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Where do you want to eat?')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter a location'),
                // 3
                onChanged: (query) => bloc.submitQuery(query),
              ),
            ),
            // 4
            Expanded(
              child: _buildResults(bloc),
            )
          ],
        ),
        
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    print('50 LocationScreen:StatelessWidget -> _buildResults() executed!');

    return StreamBuilder<List<Location>>(
      stream: bloc.locationStream,
      builder: (context, snapshot) {
        print('________________________________________________________________________');
        print('56 LocationScreen:StatelessWidget -> StreamBuilder() ${context.hashCode}');
        if(snapshot.data != null) { print('57 snapshot.data.length es: ${snapshot.data.length}'); }

        // 1
        final results = snapshot.data;

        if(results == null) {
          print('63 results == null es: ${results == null}');
          print('________________________________________________________________________');
          return Center(child: Text('Enter a location'),);
        }

        if(results.isEmpty) {
          print('69 results.isEmpty es: ${results.isEmpty}');
          print('________________________________________________________________________');
          return Center(child: Text('Enter a location'),);
        }

        print('________________________________________________________________________');

        return _buildSearchResults(results);
      }
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    print('82 LocationScreen:StatelessWidget -> _buildSearchResults() executed!');

    // 2
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        print('89 LocationScreen:StatelessWidget -> itemBuilder():$index ${context.hashCode}');

        final location = results[index];
        
        return ListTile(
          title: Text(location.title),
          onTap: () {
            // 3
            final locationBloc = BlocProvider.of<LocationBloc>(context);
            locationBloc.selectLocation(location);

            if(isFullScreenDialog) {
              Navigator.of(context).pop();
            }
          },
        );
      }
    );
  }
}