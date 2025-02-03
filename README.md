# flutter_model_gen

`flutter_model_gen` is a command-line tool designed to quickly generate boilerplate code for your Flutter project. It helps create models, services, states, controllers, and pages, all while automatically setting up essential dependencies like `get_it`, `injectable`, and `json_serializable`.

This tool makes it easier to maintain a clean architecture and speed up your development process by generating necessary files with a single command.

## Features

- Generate model classes with `@Serializable` annotations.
- Create controllers and services, automatically wired with `injectable`.
- Generate state classes as singletons.
- Create pages with linked controllers for easy navigation.
- Automatically generate `toJson` and `fromJson` functions for each model.
- Fully customizable generation based on your input.

## Installation

1. Add `flutter_model_gen` as a dependency in your `pubspec.yaml` file:

   ```yaml
   dependencies:
     flutter_model_gen: ^1.0.0
   
2. Install the dependencies:

    run in your terminal
    
    ```bash
    dart pub get
   ```

## Usage

After installing the package, you can run the flutter_model_gen command from your terminal to generate Flutter code. The command expects the model name and its attributes (fields)

## Command Syntax

```bash
dart run flutter_model_gen create_model <model_name> <field1:type1> <field2:type2> ... <fieldN:typeN>
```

## Example

Let's generate a model for a `User` with the fields `id:int`, `name:String`, and `email:String`.

_Run the following command:_

```bash
dart run flutter_model_gen create_model User id:int name:String email:String
```

## Expected Output
After running the command, the following files and content will be generated:

1. lib/models/user.dart
   ```code
   import 'package:json_annotation/json_annotation.dart';

   part 'user.g.dart';
   
   @JsonSerializable()
   class User {
   final int id;
   final String name;
   final String email;
   
   User({required this.id, required this.name, required this.email});
   
   /// Converts a JSON Map into an instance of User
   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
   
   /// Converts this instance into a JSON Map
   Map<String, dynamic> toJson() => _$UserToJson(this);
   }
   ```

2. lib/services/user_service.dart
   ```code
   import 'package:get_it/get_it.dart';
   import 'package:injectable/injectable.dart';
   import '../models/user.dart';
   
   @injectable
   class UserService {
         // Add API call functions or other methods related to the User model here
         Future<User> fetchUserData() async {
         // Example of returning a dummy user
         return User(id: 1, name: 'John Doe', email: 'john.doe@example.com');
      }
   }
   ```
   
3. lib/state/user_state.dart
   ```code
   import 'package:get_it/get_it.dart';
   import '../models/user.dart';
   
   class UserState {
      User? user;
   
      UserState();
   
      void setUser(User newUser) {
         user = newUser;
      }
   }
   
   final userState = UserState();
   ```
   
4. lib/pages/user_page.dart
   ```code
   import 'package:flutter/material.dart';
   import 'package:get_it/get_it.dart';
   import '../services/user_service.dart';
   import '../state/user_state.dart';
   
   class UserPage extends StatefulWidget {
      @override
      _UserPageState createState() => _UserPageState();
   }
   
   class _UserPageState extends State<UserPage> {
      final userService = GetIt.instance<UserService>();
   
      @override
      void initState() {
         super.initState();
         _loadUser();
      }
   
      Future<void> _loadUser() async {
         final user = await userService.fetchUserData();
         userState.setUser(user);
         setState(() {});
      }
   
      Widget build(BuildContext context) {
         return Scaffold(
            appBar: AppBar(title: Text('User Page')),
            body: userState.user == null
            ? Center(child: CircularProgressIndicator())
            : Center(child: Text('User: ${userState.user?.name}')),
         );
      }
   }
   ```
   
## Additional Notes

- You can modify and extend the generated code as per your project needs.
- The service classes can be easily linked with get_it and injectable for dependency injection.
- Models automatically include toJson and fromJson methods, making it easier to handle JSON data.

