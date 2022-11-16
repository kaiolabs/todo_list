class Task {
  int? id;
  String title;
  String description;
  String status;
  String dateExpiration;
  String dateCreation;
  String priority;
  String category;

  Task({
    this.id,
    this.title = '',
    this.description = '',
    this.status = '',
    this.dateExpiration = '',
    this.dateCreation = '',
    this.priority = '',
    this.category = '',
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["ID"],
        title: json["TITLE"],
        description: json["DESCRIPTION"],
        status: json["STATUS"],
        dateExpiration: json["DATEEXPIRATION"],
        dateCreation: json["DATECREATION"],
        priority: json["PRIORITY"],
        category: json["CATEGORY"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "TITLE": title,
        "DESCRIPTION": description,
        "STATUS": status,
        "DATEEXPIRATION": dateExpiration,
        "DATECREATION": dateCreation,
        "PRIORITY": priority,
        "CATEGORY": category,
      };
}
