import 'package:el_vaso/app/config/injection/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/my_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyD3HuhO91UVkL17Iv6FNEJhmWy63-hr2-0", // paste your api key here
      appId:
          "1:73575438412:android:621265268368541d9f7ce9", //paste your app id here
      messagingSenderId: "73575438412", //paste your messagingSenderId here
      projectId: "elvaso-a5001", //paste your project id here
    ),
  );
  FirebaseAuth.instance.setLanguageCode("es"); // Para español

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setupInjection();
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}
