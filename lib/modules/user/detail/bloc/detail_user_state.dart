import 'package:movie_db/modules/user/detail/model/detail_user_response.dart';

abstract class DetailUserState {}

class DetailUserInitial extends DetailUserState {}

class DetailUserLoading extends DetailUserState {}

class DetailUserSuccess extends DetailUserState {
  DetailUserResponse response;

  DetailUserSuccess(this.response);
}

class DetailUserFailure extends DetailUserState {
  String message;

  DetailUserFailure(this.message);
}

class DeleteUserLoading extends DetailUserState {}

class DeleteUserSuccess extends DetailUserState {
  DetailUserResponse response;

  DeleteUserSuccess(this.response);
}

class DeleteUserFailure extends DetailUserState {
  String message;

  DeleteUserFailure(this.message);
}