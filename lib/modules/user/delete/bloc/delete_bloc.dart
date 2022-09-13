import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/modules/user/delete/bloc/delete_event.dart';
import 'package:movie_db/modules/user/delete/bloc/delete_state.dart';
import 'package:movie_db/modules/user/repository/user_repo.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  late UserRepository _repository;

  DeleteBloc() : super(DeleteInitial()) {
    _repository = UserRepository.instance;

    on<MultipleDeleteUserEvent>((event, emit) async {
      emit(DeleteLoading());
      try {
        event.userIdList.forEach((element) {
          _repository.deleteData(element);
        });
        emit(DeleteSuccess("Data berhasil dihapus"));
      } catch (ex) {
        emit(DeleteFailure(ex.toString()));
      }
    });

  }
}
