import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../core/di/injection.dart';

/// User Page Widget
class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _userPageController = getIt<UserController>();

  @override
  void initState() {
    _userPageController.initialize(setState, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: _userPageController.state.loading
          ? CircularProgressIndicator()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User Details'),
                  Row(
                    children: [
                      Text('User Id:'),
                      Text(
                        _userPageController.state.user!.id.toString(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('User name:'),
                      Text(
                        _userPageController.state.user!.name,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('User Email:'),
                      Text(
                        _userPageController.state.user!.email,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
