import 'package:flutter/material.dart';
import 'package:flutter_model_gen_example/models/user.dart';
import 'package:flutter_model_gen_example/state/user_state.dart';
import 'package:injectable/injectable.dart';
import '../services/user_service.dart';

/// This is the UserController Class.
/// It connects the service and state classes then is used from the Widget class.
/// It is where all the business logic is happening.
@injectable
class UserController {
  /// UserState Instance
  final UserState state;
  final UserService _service;
  late final BuildContext _context;
  late final void Function(void Function()) _setState;

  /// UserService instance andUserState Instance are being Injected
  UserController(this._service, this.state);

  /// This function is to initialize your variables. You must call it in the initState function of your widget
  void initialize(
      void Function(void Function()) setState, BuildContext context) {
    _context = context;
    _setState = setState;
  }

  /// Fetches data using the service.
  Future<void> fetchData() async {
    state.loading = true;
    _update();
    User user = await _service.fetchUser(1);
    state.user = user;
    state.loading = false;
    _update();
  }

  /// This is for UI rebuilding but also to avoid Memory Leak
  void _update() {
    if (!_context.mounted) return;
    _setState(() {});
  }
}
