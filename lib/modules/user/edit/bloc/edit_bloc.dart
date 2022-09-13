import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/modules/user/edit/bloc/edit_event.dart';
import 'package:movie_db/modules/user/edit/bloc/edit_state.dart';
import 'package:movie_db/modules/user/repository/user_repo.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  late UserRepository _repository;

  EditBloc() : super(EditInitial()) {
    _repository = UserRepository.instance;

    on<EditUserEvent>((event, emit) async {
      emit(EditLoading());
      try {
        var response = await _repository.updateUserData(event.name, event.age, event.userId);
        if (response.success) {
          emit(EditSuccess(response));
        } else {
          emit(EditFailure(response.message));
        }
      } catch (ex) {
        emit(EditFailure(ex.toString()));
      }
    });
  }
}