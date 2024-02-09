import 'dart:developer';
import 'dart:io';

import 'package:chat_test_flutter/api/apis.dart';
import 'package:chat_test_flutter/constants/app_colors.dart';
import 'package:chat_test_flutter/helper/dialogs.dart';
import 'package:chat_test_flutter/main.dart';
import 'package:chat_test_flutter/provider/login_chat_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future<UserCredential?> signInWithGoogle() async {
      try {
        await InternetAddress.lookup("google.com");
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        return await APIs.auth.signInWithCredential(credential);
      } catch (e) {
        log("_signinwithgoogle : $e");
        Dialogs.showSnackbar(context, e.toString());
      }
      return null;
    }

    handleGoogleBtnClick() {
      Dialogs.showProgressBar(context);
      signInWithGoogle().then((user) {
        context.pop();
        if (user != null) {
          log('\nUser:${APIs.auth.currentUser}');
          context.pushReplacement("/home");
        }
      });
    }

    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcom to we Chat"),
        backgroundColor: AppColors.kWhite,
      ),
      body: Stack(
        children: [
          Consumer(builder: (context, ref, widget) {
            bool animated = ref.watch(chatIconStartProvider);
            Future.delayed(const Duration(milliseconds: 500), () {
              ref.read(chatIconStartProvider.notifier).updateState();
            });

            return AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: mq.height * .15,
              right: animated ? mq.width * .25 : -mq.width * .5,
              width: mq.width * .5,
              child: Image.asset("assets/images/chat.png"),
            );
          }),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 223, 255, 187),
                  shape: const StadiumBorder(),
                  elevation: 1,
                ),
                onPressed: () async {
                  handleGoogleBtnClick();
                },
                icon: SvgPicture.asset("assets/logo/google_logo.svg"),
                label: RichText(
                    text: const TextSpan(
                        style: TextStyle(
                          color: AppColors.kBlack,
                          fontSize: 16,
                        ),
                        children: [
                      TextSpan(text: 'Login with '),
                      TextSpan(
                          text: 'Google',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          )),
                    ]))),
          ),
        ],
      ),
    );
  }
}
