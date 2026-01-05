import 'package:ledgerly/features/authentication/data/model/user_model.dart';

class UserRepository {
  static UserModel get dummy =>
      UserModel(id: 1, name: '', email: '', password: '');
}