class Task {
  int? id;
  String title;
  String description;
  String status;
  String dateExpiration;
  String dateCreation;
  String priority;
  String category;
  bool favorite;
  Task({
    this.id,
    this.title = '',
    this.description = '',
    this.status = '',
    this.dateExpiration = '',
    this.dateCreation = '',
    this.priority = '',
    this.category = '',
    this.favorite = false,
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
        favorite: json["FAVORITE"] == 1 ? true : false,
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
        "FAVORITE": favorite ? 1 : 0,
      };
}
