class ActivityType {

   late int id;
   late String image;
   late String label;
   late String description;

  ActivityType({
    required this.id,
    required this.image,
    required this.label,
    required this.description
  });

  ActivityType.origin() {
    id = -1;
    image = "";
    label = "";
    description = "";
  }

  ActivityType.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    image = map['image'];
    label = map['label'];
    description = map['description'];
  }

}