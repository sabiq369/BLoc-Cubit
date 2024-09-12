import 'package:bloc_cubit/visibility/bloc/visibility_event.dart';
import 'package:bloc_cubit/visibility/bloc/visibility_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(VisibilityState(show: true)) {
    on<VisibilityShow>(
      (event, emit) => emit(VisibilityState(show: true)),
    );
    on<VisibilityHide>(
      (event, emit) => emit(VisibilityState(show: false)),
    );
  }
}
