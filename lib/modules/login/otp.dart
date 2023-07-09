// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, sort_child_properties_last, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_app/modules/login/auth_controller.dart';
import 'package:parking_app/modules/login/phone.dart';
import 'package:parking_app/shared/components/components.dart';
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<AuthControllers>(
        builder: (controller) => Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Images/img2.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Phone Verivification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'we need to register your phone without getting started!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onChanged: (value) {
                    code = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.signInWithPhone(
                          verify: MyPhone.verify,
                          code: code,
                        );
                      },
                      child: const Text('verify phone number'),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 27, 121, 129),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          navigateAndFinish(context, const MyPhone());
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, 'phone', (route) => false);
                        },
                        child: const Text(
                          'Edit Phone Number ?',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
