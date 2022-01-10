import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/resource.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

class TwitterSignIn {
  Future<UserCredential?> twitterSignIn() async {
    final twitterLogin = TwitterLogin(
        apiKey: 'yjqEDJ4DPSWDQ3nfyzRpSVUPt',
        apiSecretKey: 'EDll4Xek26lWbAXqkurQ4QkIV3aCwsZ8s0UsjzFt2sv2MLsk9M',
        redirectURI: 'twitter-firebase-auth://');
    final AuthResult result = await twitterLogin.login();

    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: result.authToken!, secret: result.authTokenSecret!);

    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }
}

