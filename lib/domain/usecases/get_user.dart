import 'package:ddi_phone/domain/repositories/user_repository.dart';
import 'package:ddi_phone/infrastructure/models/user_model.dart';

class GetUser{
  final UserRepository userRepository;

  GetUser(this.userRepository);

  Future<UserModel> call(String id) {
    return userRepository.getUser(id);
  }
}