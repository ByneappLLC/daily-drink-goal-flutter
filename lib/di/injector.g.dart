// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void _configureFactories() {
    final Container container = Container();
    container.registerSingleton((c) => BeersDb());
    container.registerFactory((c) => GetDrinks(c<BeersDb>()));
    container.registerFactory((c) => BeersBloc(c<GetDrinks>()));
  }
}
