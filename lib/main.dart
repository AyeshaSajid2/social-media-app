import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/view_model/chat_detail_view_model.dart';
import 'package:social_media_app/views/home_Screen.dart';
import 'package:social_media_app/views/login_Screen.dart';

import 'auth/authService.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
          ChangeNotifierProvider<ChatDetailViewModel>(
              create: (_) => ChatDetailViewModel()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.red,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.red,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.red[200],
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.red,
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.red,
              textTheme: ButtonTextTheme.primary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
          ),
          home: Consumer<AuthService>(
            builder: (context, auth, _) {
              return auth.isAuthenticated ? HomeScreen() : LoginScreen();
            },
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}
