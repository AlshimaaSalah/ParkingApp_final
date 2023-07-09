// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_app/modules/login/phone.dart';
import 'package:parking_app/modules/on_boarding/on_boarding_screen.dart';

import '../../models/user_model.dart';
import '../dataBaseCaching.dart';
import '../layout/layout_screen.dart';

FirebaseAuth auth = FirebaseAuth.instance;
SplachScreanControler splachScreanControler = SplachScreanControler.instance;
RouteController routeController = RouteController.instance;
AuthControllers authControllers = AuthControllers.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class AuthControllers extends GetxController {
  static AuthControllers instance = Get.find();
  Rx<User?>? firebaseUser = Rx<User?>(auth.currentUser);
  String usersCollection = "users";
  RxBool isOnbord = false.obs;

  Rx<UserModel> usermodels = UserModel().obs;

  @override
  void onReady() async {
    super.onReady();
    await baseCaching.isDataCacheExist("onBoarding").then((value) {
      isOnbord.value = value;
    });

    firebaseUser!.bindStream(auth.userChanges());

    ever(firebaseUser!, _setInitialScreen);
  }

  //* Sign in whih email add passrod
  void signInWithPhone({required String verify, required String code}) async {
    showLoading();
    splachScreanControler.isStart.value = false;

    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verify, smsCode: code);

      await auth.signInWithCredential(credential).then(
        (value) async {
          return await _addUserToFirestore(value.user!);
        },
      );
      dismissLoadingWidget();
    } on FirebaseAuthException catch (error) {
      dismissLoadingWidget();
      Get.snackbar(
        "Sign In Failed",
        "Try again\n${error.message}",
        titleText: const Text(
          "Sign In Failed",
        ),
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  _addUserToFirestore(User user) async {
    UserModel usermodels = UserModel(
      uId: user.uid,
      carNumber: '',
      phone: user.phoneNumber,
    );
    return await firebaseFirestore
        .collection(usersCollection)
        .doc(usermodels.uId)
        .set(
          usermodels.toMap(),
        );
  }

  updateUserData(Map<String, dynamic> data) async {
    return await firebaseFirestore
        .collection(usersCollection)
        .doc(usermodels.value.uId)
        .update(
          data,
        );
  }

  //* end Sign Up whih email add passrod

  //! google sign in methods

  //! end goole sign in nethods
  void signOut() async {
    showLoading();
    auth.signOut();
    dismissLoadingWidget();
  }

  //? end facebook sign in methods

  _setInitialScreen(User? user) async {
    if (splachScreanControler.isStart.value) {
      await Future.delayed(
        const Duration(seconds: 5),
        () {
          _checkUser(user);
        },
      );
    } else {
      _checkUser(user);
    }
  }

  void _checkUser(User? user) async {
    if (!isOnbord.value) {
      Get.offAll(const OnBoardingScreen());
    } else {
      if (user == null) {
        routeController.routePage(
          type: 'offAll',
          page: () => const MyPhone(),
        );
        // await MySharedPreferences.saveUserID('null');
        // userToken = await MySharedPreferences.getGetuserID();
      } else {
        usermodels.bindStream(listenToUser());
        // dismissLoadingWidget();
        routeController.routePage(
          type: 'offAll',
          page: () => const LayoutScreen(),
          arguments: 0.obs,
        );
        // await MySharedPreferences.saveUserID(user.uid.toString());
        // userToken = await MySharedPreferences.getGetuserID();
      }
    }
  }

  Stream<UserModel> listenToUser() {
    return firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser!.value!.uid)
        .snapshots()
        .map(
          (snapshot) => UserModel.fromJson(
            snapshot.data(),
          ),
        );
  }
}

class SplachScreanControler extends GetxController {
  static SplachScreanControler instance = Get.find();
  Rx<bool> isStart = false.obs;

  @override
  void onReady() {
    super.onReady();
    isStart.value = true;
  }
}

class RouteController extends GetxController {
  static RouteController instance = Get.find();

  routePage({
    required String type,
    required dynamic page,
    dynamic arguments,
  }) {
    switch (type) {
      case 'offAll':
        Get.offAll(
          page,
          transition: Transition.zoom,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          arguments: arguments ?? null,
        );

        break;
      case 'to':
        Get.to(
          page,
          transition: Transition.zoom,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          arguments: arguments ?? null,
        );
        break;
      default:
    }
  }
}

showLoading() {
  Get.defaultDialog(
    title: "Loading...",
    titleStyle: const TextStyle(
      color: Colors.lightGreenAccent,
      fontSize: 14,
    ),
    content: const CircularProgressIndicator(),
    barrierDismissible: false,
  );
}

dismissLoadingWidget() {
  Get.back();
}
