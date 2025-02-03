import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('❌ Usage: flutter_gen create_model ModelName field:type field:type');
    exit(1);
  }

  final command = arguments[0];

  if (command == 'create_model' && arguments.length > 1) {
    final modelName = arguments[1];
    final fields = arguments.skip(2).toList();

    print('✨ Generating files for model: $modelName');
    _generateModel(modelName, fields);
    _generateService(modelName);
    _generateController(modelName);
    _generateState(modelName);
    _generatePage(modelName);
  } else {
    print(
        '❌ Invalid command. Use: flutter_gen create_model ModelName field:type field:type');
    exit(1);
  }
}

void _generateModel(String name, List<String> fields) {
  final className = _capitalize(name);
  final fileName = _snakeCase(name);
  final fileContent = '''
import 'package:json_annotation/json_annotation.dart';

part '$fileName.g.dart';

@JsonSerializable()
class $className {
  ${fields.map((f) => 'final ${_parseType(f)} ${_parseField(f)};').join('\n  ')}

  $className({${fields.map((f) => 'required this.${_parseField(f)}').join(', ')}});

  /// Converts a JSON Map into an instance of $className
  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);

  /// Converts this instance into a JSON Map
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);
}
  ''';

  _writeFile('lib/models/$fileName.dart', fileContent);

  // Automatically run build_runner to generate the *.g.dart file
  _runBuildRunner();
}

void _generateService(String name) {
  final className = _capitalize(name);
  final fileName = _snakeCase(name);
  final fileContent = '''
import '../models/$fileName.dart';

class ${className}Service {
  Future<$className> fetch$className() async {
    // Simulate API call
    return $className();
  }
}
  ''';

  _writeFile('lib/services/${fileName}_service.dart', fileContent);
}

void _generateController(String name) {
  final className = _capitalize(name);
  final fileName = _snakeCase(name);
  final fileContent = '''
import 'package:injectable/injectable.dart';
import '../services/${fileName}_service.dart';

@injectable
class ${className}Controller {
  final ${className}Service _service;

  ${className}Controller(this._service);

  void fetchData() {
    _service.fetch$className();
  }
}
  ''';

  _writeFile('lib/controllers/${fileName}_controller.dart', fileContent);
}

void _generateState(String name) {
  final className = _capitalize(name);
  final fileName = _snakeCase(name);
  final fileContent = '''
class ${className}State {
  static final ${className}State _instance = ${className}State._internal();
  
  factory ${className}State() => _instance;

  ${className}State._internal();
}
  ''';

  _writeFile('lib/state/${fileName}_state.dart', fileContent);
}

void _generatePage(String name) {
  final className = _capitalize(name);
  final fileName = _snakeCase(name);
  final fileContent = '''
import 'package:flutter/material.dart';
import '../controllers/${fileName}_controller.dart';

class ${className}Page extends StatelessWidget {
  final ${className}Controller controller;

  ${className}Page(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$className Page')),
      body: Center(child: Text('Welcome to $className Page')),
    );
  }
}
  ''';

  _writeFile('lib/pages/${fileName}_page.dart', fileContent);
}

void _writeFile(String path, String content) {
  final file = File(path);
  file.createSync(recursive: true);
  file.writeAsStringSync(content);
  print('✅ Created: $path');
}

String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
String _snakeCase(String s) => s
    .replaceAllMapped(RegExp(r'[A-Z]'), (m) => '_${m.group(0)?.toLowerCase()}')
    .substring(1);
String _parseField(String field) => field.split(':')[0];
String _parseType(String field) {
  final type = field.split(':')[1].toLowerCase();
  switch (type) {
    case 'int':
      return 'int';
    case 'double':
      return 'double';
    case 'string':
      return 'String';
    case 'bool':
      return 'bool';
    case 'int?':
      return 'int?';
    case 'double?':
      return 'double?';
    case 'string?':
      return 'String?';
    case 'bool?':
      return 'bool?';
    default:
      return 'dynamic';
  }
}

void _runBuildRunner() async {
  final result = await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    workingDirectory: Directory.current.path,
  );

  if (result.exitCode == 0) {
    print('Build runner completed successfully!');
  } else {
    print('Error running build_runner: ${result.stderr}');
  }
}
