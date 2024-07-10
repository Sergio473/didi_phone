import 'package:ddi_phone/infrastructure/models/user_model.dart';

abstract class UserRepository{
  Future<UserModel> getUser(String id);
}