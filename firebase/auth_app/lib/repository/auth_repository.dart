import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void signOut() async {

    if (auth.currentUser.providerData.single.providerId == "google.com") {
      await GoogleSignIn().signOut();
      await auth.signOut();
    } else if (auth.currentUser.providerData.single.providerId == "password") {
      await auth.signOut();
    } else {
      await auth.signOut();
    }
  }
  // void signOutWithGoogle() async {
  //   await GoogleSignIn().signOut();
  //   await auth.signOut();
  // }

  Future<User> getUser() async {
    return auth.currentUser;
  }

  Future<void> signInWithEmailAndPassword(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUpWithEmailAndPassword(String _email, String _password) async {
    await auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }
}
