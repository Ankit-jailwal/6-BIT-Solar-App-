import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Authentication{

  static Future<User> signInWithGoogle({ BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        //print("The account already exists with a different credential.");
         ScaffoldMessenger.of(context).showSnackBar(
         Authentication.customSnackBar(
         content:
           'The account already exists with a different credential.',
         ),
    );
  } else if (e.code == 'invalid-credential') {
    //print('Error occurred while accessing credentials. Try again.');
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
        content:
            'Error occurred while accessing credentials. Try again.',
      ),
    );
  }
} catch (e) {
  //print('Error occurred using Google Sign-In. Try again.');
  ScaffoldMessenger.of(context).showSnackBar(
    Authentication.customSnackBar(
      content: 'Error occurred using Google Sign-In. Try again.',
    ),
  );
}
   return user;
  }
}

static Future<void> signOut({ BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      //print('Error signing out. Try again.');
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

static SnackBar customSnackBar({String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}

}



// class AuthService{

//   final FirebaseAuth _auth = FirebaseAuth.instance;


// // // sign in with google
//   Future googleSignIn() async{

//     try{

//       await _auth.signing

//     }catch(e){

//     }

//   }
// // register with google

// // signout

// }