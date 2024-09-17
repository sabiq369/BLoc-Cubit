import 'package:bloc_cubit/bloc/user_event.dart';
import 'package:bloc_cubit/bloc/user_state.dart';
import 'package:bloc_cubit/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;
  UserBloc(this._repository) : super(UserInitialState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _repository.getUsers();
        emit(UserSuccessState(userModel: users));
      } catch (e) {
        emit(UserErrorState(error: e.toString()));
      }
    });
  }
}
