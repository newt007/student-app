import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/modules/user/add/bloc/add_event.dart';
import 'package:movie_db/modules/user/add/bloc/add_state.dart';
import 'package:movie_db/modules/user/repository/user_repo.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  late UserRepository _repository;

  AddBloc() : super(InitAddState()) {
    _repository = UserRepository.instance;

    on<AddNewPostEvent>((event, emit) async {
      emit(ShowLoadingAddState());
      try {
        var map = await _repository.postUser(event.name, event.age);
        if (map.success) {
          emit(ShowResultAddState(map));
        }
      } catch (ex) {
        emit(ShowErrorAddState(ex.toString()));
      }
    });
  }
}
