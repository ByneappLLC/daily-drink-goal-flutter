import 'dart:async';
import 'package:bloc/bloc.dart';
import './beers.dart';

class BeersBloc extends Bloc<BeersEvent, BeersState> {
  @override
  BeersState get initialState => InitialBeersState();

  @override
  Stream<BeersState> mapEventToState(
    BeersEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
