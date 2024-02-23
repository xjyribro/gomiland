import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<String?> signIn({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    await signInWithUsernameAndPassword(email: email, password: password);
    return null;
  } on FirebaseAuthException catch (e) {
    final String message = e.message ?? '';
    if (message.contains('There is no user record')) {
      return 'There is no user record';
    } else if (message.contains('The password is invalid')) {
      return 'The password is invalid';
    }
    return 'Error has occurred';
  }
}

Future<UserCredential> signInWithUsernameAndPassword({
  required String email,
  required String password,
}) async {
  return await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future<String?> signUp({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    await createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      signInWithUsernameAndPassword(email: email, password: password);
    });
    return null;
  } on FirebaseAuthException catch (e) {
    final String message = e.message ?? '';
    if (message.contains('The email address is already in use')) {
      return 'The email address is already in use';
    }
    return 'Error has occurred';
  }
}

Future<UserCredential> createUserWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  return await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}


