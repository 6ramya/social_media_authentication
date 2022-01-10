import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/auth/facebook_sign_in.dart';
import 'package:firebase_demo/auth/google_sign_in.dart';
import 'package:firebase_demo/resource.dart';
import 'package:firebase_demo/auth/twitter_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(children: [
        const Spacer(),
        const FlutterLogo(size: 120),
        const Spacer(),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Hey There,\nWelcome Back',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Login to your account to continue',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50)),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            },
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
            label: Text('Sign Up with Google')),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50)),
            onPressed: () {
              FacebookSignInProvider().facebookSignIn();
            },
            icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
            label: Text('Sign Up with Facebook')),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50)),
            onPressed: () async {
              TwitterSignIn().twitterSignIn();
           
            },
            icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.blue),
            label: Text('Sign Up with Twitter')),
        const SizedBox(
          height: 40,
        ),
        RichText(
            text: TextSpan(text: 'Already have an account?', children: [
          TextSpan(
              text: 'Log in',
              style: TextStyle(decoration: TextDecoration.underline))
        ])),
        const Spacer()
      ]),
    );
  }
}
