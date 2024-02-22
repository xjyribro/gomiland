import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
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

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<bool?> checkAccountHasPassword() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) return null;
  bool hasPassword = false;
  for (final providerProfile in user.providerData) {
    final provider = providerProfile.providerId;
    if (provider == 'password') {
      hasPassword = true;
    }
  }
  return hasPassword;
}

Future<List<String>> checkAccountAuthProvider() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) return [];
  List<String> providerIds = [];
  for (final providerProfile in user.providerData) {
    final provider = providerProfile.providerId;
    providerIds.add(provider);
  }
  return providerIds;
}
