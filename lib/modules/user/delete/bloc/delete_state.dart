abstract class DeleteState {}

class DeleteInitial extends DeleteState {}

class DeleteLoading extends DeleteState {}

class DeleteSuccess extends DeleteState {
  final String message;

  DeleteSuccess(this.message);
}

class DeleteFailure extends DeleteState {
  final String message;

  DeleteFailure(this.message);
}