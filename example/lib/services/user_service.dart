import 'package:injectable/injectable.dart';

import '../models/user.dart';

/// This Class is responsible for making all API calls for User
@singleton
class UserService {
  /// Function to fetch User by id
  Future<User> fetchUser(int id) async {
    // Simulate API call
    await Future.delayed(
      Duration(
        seconds: 3,
      ),
    );
    return User(
      id: id,
      name: 'name',
      email: 'email',
    );
  }
}
