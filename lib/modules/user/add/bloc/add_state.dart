import '../model/add_user_response.dart';

abstract class AddState {}

class InitAddState extends AddState {}

class ShowLoadingAddState extends AddState {}

class ShowResultAddState extends AddState {
  AddUserResponse response;

  ShowResultAddState(this.response);
}

class ShowErrorAddState extends AddState {
  String message;

  ShowErrorAddState(this.message);
}