abstract class DetailUserEvent {}

class GetDetailUserEvent extends DetailUserEvent {
  final int userId;

  GetDetailUserEvent(this.userId);
}

class DeleteUserEvent extends DetailUserEvent {
  final int userId;

  DeleteUserEvent(this.userId);
}