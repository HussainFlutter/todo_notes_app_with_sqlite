enum Priority { low, med, high }

class NoteModel {
  final String? title;
  final String? description;
  final int? id;
  final Priority? priority;
  final String? createAt;

  NoteModel({
       this.title,
       this.description,
       this.id,
       this.priority,
       this.createAt,
  });

  factory NoteModel.fromMap ( Map<String,dynamic> data ) {
    print("note $data");
    late Priority priority;
    if(data["priority"] == Priority.low.toString())
      {
        priority = Priority.low;
      }
    else if (data["priority"] == Priority.med.toString()) {
      priority = Priority.med;

    }
    else if (data["priority"] == Priority.high.toString()) {
      priority = Priority.high;
    }
    else {
      priority = Priority.low;
    }
    print(data["title"]);
    print(data["description"]);
    print(data["id"]);
    print(priority);
    print(data["createAt"]);
    return NoteModel(
      title: data["title"]?? "WAA",
      description: data["description"],
      id: data["id"] ?? "wee",
      priority: priority,
      createAt: data["createAt"],
    );
  }

  Map<String,dynamic> toMap () {
    return {
      "title":title,
      "description":description,
      "id":id,
      "priority":priority.toString(),
      "createAt":createAt,
    };
  }
}
