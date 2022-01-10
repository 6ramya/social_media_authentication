import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/pages/contacts_page.dart';

import 'package:firebase_demo/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              print(snapshot);
              return ContactsListPage();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!!'));
            } else {
              return SignInPage();
            }
          }),
    );
  }
}
