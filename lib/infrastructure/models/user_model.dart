import 'package:ddi_phone/domain/entities/user.dart';

class UserModel extends User{
  UserModel({required String id, required String name}) : 
  super(id: id, name: name);

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json["id"].toString(), 
      name: json["name"], 
      );
  }
}