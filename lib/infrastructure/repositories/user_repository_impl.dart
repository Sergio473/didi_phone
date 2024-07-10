import 'package:ddi_phone/domain/repositories/user_repository.dart';
import 'package:ddi_phone/infrastructure/data_sources/user_data_source.dart';
import 'package:ddi_phone/infrastructure/models/user_model.dart';

class UserRepositoryImpl implements UserRepository{
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<UserModel> getUser(String id) {
    return dataSource.fetchUser(id);
    
  }
}