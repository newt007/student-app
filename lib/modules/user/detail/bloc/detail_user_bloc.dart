import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/modules/user/detail/bloc/detail_user_event.dart';
import 'package:movie_db/modules/user/detail/bloc/detail_user_state.dart';
import 'package:movie_db/modules/user/repository/user_repo.dart';

class DetailUserBloc extends Bloc<DetailUserEvent, DetailUserState> {
  late UserRepository _repository;

  DetailUserBloc() : super(DetailUserInitial()) {
    _repository = UserRepository.instance;

    on<GetDetailUserEvent>(
      (event, emit) async {
        emit(DetailUserLoading());

        try {
          var response = await _repository.getDetailUser(event.userId);

          if (response.success) {
            emit(DetailUserSuccess(response));
          } else {
            emit(DetailUserFailure(response.message));
          }
        } catch (ex) {
          emit(DetailUserFailure(ex.toString()));
        }
      },
    );

    on<DeleteUserEvent>((event, emit) async {
      emit(DeleteUserLoading());

      try {
        var response = await _repository.deleteData(event.userId);

        if (response.success) {
          emit(DeleteUserSuccess(response));
        } else {
          emit(DeleteUserFailure(response.message));
        }
      } catch (ex) {
        emit(DeleteUserFailure(ex.toString()));
      }
    });

  }
}
