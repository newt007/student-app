import 'package:movie_db/modules/user/detail/model/detail_user_response.dart';

abstract class EditState {}

class EditInitial extends EditState {}

class EditLoading extends EditState {}

class EditSuccess extends EditState {
  DetailUserResponse response;

  EditSuccess(this.response);
}

class EditFailure extends EditState {
  String message;

  EditFailure(this.message);
}