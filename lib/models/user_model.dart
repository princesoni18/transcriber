class UserModel {


 final String name;
  final String email;
  

  final String uid;

  UserModel({required this.name, required this.email,  required this.uid});

   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        uid: json["uid"],
        email: json["email"],
       
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "email": email,
       
    };
}