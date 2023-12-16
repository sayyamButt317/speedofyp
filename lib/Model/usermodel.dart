class UserModel {
  String? image;
  String? name;
  String? phone;

   UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
  }
}
