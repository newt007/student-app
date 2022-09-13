import '../model/get_user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState{}

class UserSuccess extends UserState {
  GetUserResponse response;

  UserSuccess(this.response);
}

class UserFailure extends UserState {
  String message;

  UserFailure(this.message);
}