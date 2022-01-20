import 'package:biolinktree_assignment/appConfig.dart';
import 'package:biolinktree_assignment/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => print('initialized'));
  runApp(
    MultiProvider(
      child: AppConfig(),
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
    ),
  );
}
