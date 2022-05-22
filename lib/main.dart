import 'package:flutter/material.dart';
import 'package:mvvm_demo/src/user_functionality/services/dependency_assembler_education.dart'
    as user;
import 'src/user_functionality/ui/views/movie_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await user.setupDependencyAssemblerEducation();
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.blue),
    home: const MovieScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
