import 'package:flutter/material.dart';

// Bloc pattern

/// All Blocs extends from this
abstract class BlocBase{
  void dispose();
}

/// Blocs are associated to a StatefulWidget.child
abstract class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key : key);

  final T bloc;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _BlocProviderState<T>();

  static T of<T>(BuildContext context) {
    final type = _typeOf<_BlocInheritedContainer<T>>();
    _BlocInheritedContainer<T> provider = context.inheritFromWidgetOfExactType(type);
    return provider?.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {

  @override
  Widget build(BuildContext context) {
    return new _BlocInheritedContainer(bloc : widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

class _BlocInheritedContainer<T> extends InheritedWidget {
  final T bloc;

  _BlocInheritedContainer({key, this.bloc, child}) : super(key : key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

}