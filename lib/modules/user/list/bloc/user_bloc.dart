import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/modules/user/list/bloc/user_event.dart';
import 'package:movie_db/modules/user/list/bloc/user_state.dart';
import 'package:movie_db/modules/user/repository/user_repo.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late UserRepository _repository;

  UserBloc(): super(UserInitial()) {
    _repository = UserRepository.instance;

    on<GetListUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        var response = await _repository.getUser();

        if(response.success) {
          emit(UserSuccess(response));
        } else {
          emit(UserFailure(response.message));
        }
      } catch (ex) {
        emit(UserFailure(ex.toString()));
      }
    });
  }

}