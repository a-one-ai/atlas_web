
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc(super.initialState) {
    on<LandingInitialEvent>(_onInitialize);
  }

  _onInitialize(
    LandingInitialEvent event,
    Emitter<LandingState> emit,
  ) {}
}
