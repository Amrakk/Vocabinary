import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
   final FirebaseAuth  _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  User? get currentUser => _firebaseAuth.currentUser;
  // Singleton
  AuthenticationService._privateConstructor();
  static final AuthenticationService _instance = AuthenticationService._privateConstructor();
  static AuthenticationService get instance => _instance;

  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found') {
        return "No user found for that email";
      } else if(e.code == 'wrong-password') {
        return "Wrong password provided for that user";
      } else if(e.code == 'invalid-email') {
        return "Invalid email";
      } else {
        return e.message;
      }
    }
  }

  Future<dynamic> signUp({required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'weak-password') {
        return "The password provided is too weak";
      } else if(e.code == 'email-already-in-use') {
        return "The account already exists for that email";
      } else if(e.code == 'invalid-email') {
        return "Invalid email";
      } else {
        return e.message;
      }
    }
  }
   Future<bool> isEmailRegistered(String email) async {
     try {
       final user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: 'dummyPassword')).user;
       return user != null;
     } on FirebaseAuthException catch (e) {
       if (e.code == 'wrong-password') {
         return true; // The email is registered with a different password
       } else if (e.code == 'user-not-found') {
         return false; // The email is not registered
       } else {
         throw e; // Some other error occurred
       }
     }
   }

  Future<bool> sendEmailResetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}
