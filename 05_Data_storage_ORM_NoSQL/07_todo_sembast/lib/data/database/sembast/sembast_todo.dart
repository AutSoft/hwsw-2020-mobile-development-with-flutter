class SembastTodo {
  int id;
  String title;
  String dueDate;
  bool isDone;
  String description;
  int priority;

  SembastTodo({
    this.id,
    this.title,
    this.dueDate,
    this.isDone,
    this.description,
    this.priority,
  });

  factory SembastTodo.fromMap(int id, Map<String, dynamic> map) {
    return SembastTodo(
      id: id,
      title: map['title'],
      dueDate: map['dueDate'],
      isDone: map['isDone'],
      description: map['description'],
      priority: map['priority'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'dueDate': this.dueDate,
      'isDone': this.isDone,
      'description': this.description,
      'priority': this.priority,
    };
  }
}
