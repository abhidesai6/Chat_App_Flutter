import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/helper/helperFunctions.dart';

import 'package:chat_app/modal/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final Firestore _db = Firestore.instance;
  String uid ;

  
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: uid = user.uid): null;
  }

  Future signInWithEmail(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email.toString().trim(), password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
       FirebaseUser firebaseUser = result.user;
       return _userFromFirebaseUser(firebaseUser); 
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e)
    {
      print(e.toString());
    }
  }

  Future <void> signInWithGoogle() async
  { 
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));
     FirebaseUser firebaseUser = result.user;
     DocumentReference ref = _db.collection('users').document(firebaseUser.uid );
     ref.setData({ 'email': firebaseUser.email, 'name': firebaseUser.displayName});
     //Constants.uid = firebaseUser.uid ;
     HelperFunctions.saveUserUidSharedPreference(firebaseUser.uid);
     HelperFunctions.saveUserNameInSharedPreference(firebaseUser.displayName);
     return _userFromFirebaseUser(firebaseUser);

  }
}

