abstract class AddEvent {}

class AddNewPostEvent extends AddEvent {
  final String name;
  final String age;

  AddNewPostEvent(this.name, this.age);
}
