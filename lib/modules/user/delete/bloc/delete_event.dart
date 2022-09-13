abstract class DeleteEvent {}

class MultipleDeleteUserEvent extends DeleteEvent {
  final List<int> userIdList;

  MultipleDeleteUserEvent(this.userIdList);
}