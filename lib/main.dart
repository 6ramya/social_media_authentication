import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/auth/google_sign_in.dart';
import 'package:firebase_demo/pages/homepage.dart';
import 'package:firebase_demo/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
              primaryColor: Colors.indigo,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: HomePage()),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }

//   // @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Homepage')),
//         body: Center(
//           child: ElevatedButton(
//               child: Text('Go to Contacts'),
//               onPressed: () async {
//                 await _initializeFirebase();
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => HomePage()));
//               }),
//         ));
//   }
// }
