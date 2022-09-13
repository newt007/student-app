abstract class EditEvent {}

class EditUserEvent extends EditEvent {
  final String name;
  final String age;
  final int userId;

  EditUserEvent(this.name, this.age, this.userId);
}