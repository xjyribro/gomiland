import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<void> login({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    await loginWithUsernameAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      if (kDebugMode) {
        print('user-not-found');
      }
    } else if (e.code == 'user-disabled') {
      if (kDebugMode) {
        print('user-disabled');
      }
    } else if (e.code == 'wrong-password') {
      if (kDebugMode) {
        print('wrong-password');
      }
    }
  }
}

Future<UserCredential> loginWithUsernameAndPassword({
  required String email,
  required String password,
}) async {
  return await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future<void> signUp({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    await createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      loginWithUsernameAndPassword(email: email, password: password)
          .then((userCredentials) async {
        await userCredentials.user!.sendEmailVerification();
        await signOut();
      });
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      if (kDebugMode) {
        print('Account exists');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
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

Future<UserCredential?> signInUpWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) throw Exception("Not logged in");
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return null;
}

Future<AuthCredential?> getGoogleCredentials() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
  if (googleUser == null) throw Exception("Not logged in");
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  return GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
}

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

Future<void> signInWithApple() async {
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);
  getAppleCredentials(nonce).then((credential) async {
    if (credential != null) {
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        rawNonce: rawNonce,
      );
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    }
  });
}

Future<AuthorizationCredentialAppleID?> getAppleCredentials(String nonce) async {
  try {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    return credential;
  } catch (e) {
    return null;
  }
}

Future<void> signOut() async {
  if (await GoogleSignIn().isSignedIn()) {
    GoogleSignIn().disconnect();
  }
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
