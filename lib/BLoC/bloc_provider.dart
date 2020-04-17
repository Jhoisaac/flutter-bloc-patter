import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc.dart';

// 1
class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  // 2
  static T of<T extends Bloc>(BuildContext context) {
    /*final type = _providerType<BlocProvider<T>>();*/
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }

  // 3
  /*static Type _providerType<T>() => T;*/

  @override
  _BlocProviderState createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 4
  @override
  /*Widget build(BuildContext context) => widget.child;*/
  Widget build(BuildContext context) {
    print('\n=========================================================================================');
    print('32 BlocProvider:StatefulWidget -> build() ${widget.hashCode} -> ${widget.bloc.nameTypeBloc}');
    print('=========================================================================================');

    return widget.child;
  }

  // 5
  @override
  void dispose() {
    print('\n=========================================================================================');
    print('42 BlocProvider:StatefulWidget -> dispose() ${widget.hashCode} -> ${widget.bloc.nameTypeBloc}');
    print('=========================================================================================');

    widget.bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('\n=========================================================================================');
    print('52 BlocProvider:StatefulWidget -> initState():${widget.hashCode} -> ${widget.bloc.nameTypeBloc}');
    print('=========================================================================================');
    super.initState();
  }

  @override
  void didUpdateWidget(BlocProvider<Bloc> oldWidget) {
    print('\n=========================================================================================');
    print('60 BlocProvider:StatefulWidget -> didUpdateWidget():${widget.hashCode} -> ${widget.bloc.nameTypeBloc}');
    print('61 BlocProvider:StatefulWidget -> didUpdateWidget():oldWidget es: $oldWidget -> ${widget.bloc.nameTypeBloc}');
    print('62 BlocProvider:StatefulWidget -> didUpdateWidget():oldWidget.bloc.nameTypeBloc es: ${oldWidget.bloc.nameTypeBloc} -> ${widget.bloc.nameTypeBloc}');
    print('60 BlocProvider:StatefulWidget -> didUpdateWidget():if(oldWidget == widget) es: ${oldWidget == widget}');
    print('60 BlocProvider:StatefulWidget -> didUpdateWidget():if(oldWidget != widget) es: ${oldWidget != widget}');
    print('=========================================================================================');    
    super.didUpdateWidget(oldWidget);
  }
}