import 'package:flutter/material.dart';

import 'core/di/injection.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(MyApp());
}

/// Initial Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_model_gen Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamplePage(),
    );
  }
}

/// Actual Example of how the Controller is used inside a widget.
class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_model_gen Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Example usage of your package
            var model = User(
              id: 1,
              name: 'full name',
              email: 'email',
            ); // Replace with actual usage of your package
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text('Generated Model: $model'),
              ),
            );
          },
          child: Text('Generate Model'),
        ),
      ),
    );
  }
}
