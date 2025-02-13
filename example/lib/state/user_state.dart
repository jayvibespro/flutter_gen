import 'package:flutter_model_gen_example/models/user.dart';
import 'package:injectable/injectable.dart';

///UserState. This class Contains all data user in the UserPage Widget
@singleton
class UserState {
  /// Is set to true whenever we do an API call
  bool loading = false;

  /// User Instance. This will be set to the one from the UserService fetchUser function
  User? user;
}
