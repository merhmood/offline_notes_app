import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offline_notes/models/notes_table.dart';
import 'package:offline_notes/screens/dashbord.dart';
import 'package:offline_notes/screens/notes_editor/add.dart';
import 'package:offline_notes/screens/notes_editor/edit.dart';
import 'package:offline_notes/widgets/custom_app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotesTable().connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CustomAppTheme.distributedTheme(),
        fontFamily: 'Poppins',
      ),
      routerConfig: GoRouter(
        routes: [
          // Navigates to DashBoard Screen
          GoRoute(
            path: '/',
            builder: (context, state) => const DashBoard(),
          ),
          // Navigates to Add Screen
          GoRoute(
            path: '/notes-editor/add',
            builder: (context, state) => const Add(),
          ),
          // Navigates to Edit Screen
          GoRoute(
            path: '/notes-editor/edit/:noteId',
            builder: (context, state) =>
                Edit(id: state.pathParameters['noteId']),
          ),
        ],
      ),
    );
  }
}
