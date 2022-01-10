import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

class FacebookSignInProvider {
  Future<UserCredential> facebookSignIn() async {
    final LoginResult result = await FacebookAuth.instance.login();
    final AuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  Future facebookLogOut() async {
    FacebookAuth.instance.logOut();
    FirebaseAuth.instance.signOut();
  }
}
