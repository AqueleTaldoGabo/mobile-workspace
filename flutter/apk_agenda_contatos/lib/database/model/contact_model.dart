String idColumn = "idColumn";
String nameColumn = "nameColumn";
String emailColumn = "emailColumn";
String phoneColumn = "phoneColumn";
String imgColumn = "imgColumn";
String contactTable = "contactTable";

class Contact{
  Contact({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.img,
  });

  int? id;
  String name;
  String email;
  String phone;
  String? img;
}