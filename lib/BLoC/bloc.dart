abstract class Bloc {
  String _name;
  String get nameTypeBloc => _name;

  Bloc({String name}) {
    _name = name;
  }

  void dispose();
}