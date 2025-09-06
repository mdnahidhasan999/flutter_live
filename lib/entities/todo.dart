class Todo {
  String title;
  String description;
  DateTime time;
  bool done;

  Todo(this.title, this.description, this.time, [this.done = false]);
}
