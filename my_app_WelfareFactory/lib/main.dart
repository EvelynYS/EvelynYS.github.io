import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/services/auth/auth_gate.dart';
import 'package:my_app/firebase_options.dart';
import 'package:my_app/models/factory.dart' as MyAppFactory;
// import 'package:my_app/auth/login_or_register.dart';
// import 'package:my_app/pages/home_page.dart';
// import 'package:my_app/pages/register_page.dart';
import 'package:my_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';
// import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// // 强制将 defaultTargetPlatform 设置为 Android
//   debugDefaultTargetPlatformOverride = TargetPlatform.android;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => MyAppFactory.Factory()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthGate(),
        theme: Provider.of<ThemeProvider>(context).themeData);
  }
}
