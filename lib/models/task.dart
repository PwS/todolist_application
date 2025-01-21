class Task {
  final int status;
  final int id;
  final String content;

  Task({required this.status,required  this.id,required  this.content});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'id': id,
      'content': content,
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      status: map['status'] as int,
      id: map['id'] as int,
      content: map['content'] as String,
    );
  }
}
