// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/models/authentication_request_model.dart';
import 'package:parking_app/models/order_registration_model.dart';
import 'package:parking_app/models/parking_model.dart';
import 'package:parking_app/models/payment_reqeust_model.dart';
import 'package:parking_app/modules/cubit/states.dart';
import 'package:parking_app/modules/google_map/Home.dart';
import 'package:parking_app/modules/parking_screen.dart';
import 'package:parking_app/shared/components/constants.dart';
import 'package:parking_app/shared/network/local/dio_helper.dart';

class ParkingCubit extends Cubit<ParkingStates> {
  ParkingCubit() : super(ParkingInitialState());

  static ParkingCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    Home(),
    const ParkingScreen(),
  ];

  //List<String> titles = ['Home', 'Parking Places'];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ParkingChangeBottomNavState());
  }

  var selectDate;

  void datePicker(context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2050))
        .then((value) {
      if (value == null) {
        selectDate = 'Select your Date'.toString();
        emit(ChangeDatePickerState());
      } else {
        selectDate = value;
        emit(ChangeDatePickerState());
      }
    });
  }

  var selectTime;

  void timePicker(context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      useRootNavigator: false,
    ).then((value) {
      if (value == null) {
        selectDate = 'Select your Time'.toString();
        emit(ChangeTimePickerState());
      } else {
        selectTime = value;
        emit(ChangeTimePickerState());
      }
    });
  }

  late ParkingModel model;
  List<ParkingModel> parking = [
    ParkingModel(
        image: 'assets/Images/p5.jpg',
        title: 'ESmart',
        address: 'Engineering,Al_Azhar University ',
        price: '10 LE',
        spotNum: 4),
  ];

  int counter = 0;

  int spotNum() {
    counter = 0;
    if (ir1 == true) {
      counter++;
    }
    if (ir2 == true) {
      counter++;
    }
    if (ir3 == true) {
      counter++;
    }
    if (ir4 == true) {
      counter++;
    }
    print('**counter= $counter ');
    return counter;
  }

  bool ir1 = false;
  bool ir2 = false;
  bool ir3 = false;

  bool ir4 = false;
  final database = FirebaseDatabase.instance.ref();

  void getData() async {
    emit(DataGetting());
    print('**********************************');
    try {
      final snap = await database.child('Sensor').get();
      final data = snap.value as Map;
      print('DATA $data');
      ir1 = data['sensorOne'];
      ir2 = data['sensorTwo'];
      ir3 = data['sensorThree'];
      ir4 = data['sensorFour'];
      emit(DataGot());
    } catch (e) {
      emit(DataError(e.toString()));
      print(e.toString());
    }
    database.child('Sensor').onChildChanged.listen((event) {
      DataSnapshot snap = event.snapshot;
      if (snap.key == 'sensorOne') {
        ir1 = snap.value as bool;
        emit(DataGot());
      }
      if (snap.key == 'sensorTwo') {
        ir2 = snap.value as bool;
        emit(DataGot());
      }
      if (snap.key == 'sensorThree') {
        ir3 = snap.value as bool;
        emit(DataGot());
      }
      if (snap.key == 'sensorFour') {
        ir4 = snap.value as bool;
        emit(DataGot());
      }
    });
  }

//Timer
  int timer1 = 0;
  int timer2 = 0;
  int timer3 = 0;
  int timer4 = 0;
  int activeSpot = 0;
  double totalCost = 0;

  double hourlyRate = 10;

  bool parkingOccupied1 = false;
  bool parkingOccupied2 = false;
  bool parkingOccupied3 = false;
  bool parkingOccupied4 = false;

  String formatTime(int time) {
    int hours = time ~/ 3600;
    int minutes = (time ~/ 60) % 60;
    int seconds = time % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void startTimer(int spot) {
    switch (spot) {
      case 1:
        timer1 = 0;
        Timer.periodic(const Duration(seconds: 1), (Timer t) {
          timer1++;
          totalCost = hourlyRate * (timer1 / 3600);
          emit(ParkingUpdated());
        });
        break;
      case 2:
        timer2 = 0;
        Timer.periodic(const Duration(seconds: 1), (Timer t) {
          timer2++;
          totalCost = hourlyRate * (timer2 / 3600);
          emit(ParkingUpdated());
        });
        break;
      case 3:
        timer3 = 0;
        Timer.periodic(const Duration(seconds: 1), (Timer t) {
          timer3++;
          totalCost = hourlyRate * (timer3 / 3600);
          emit(ParkingUpdated());
        });
        break;
      case 4:
        timer4 = 0;
        Timer.periodic(const Duration(seconds: 1), (Timer t) {
          timer4++;
          totalCost = hourlyRate * (timer4 / 3600);
          emit(ParkingUpdated());
        });
        break;
    }
  }

  void updateSensor(int spot, bool value) {
    switch (spot) {
      case 1:
        ir1 = value;
        parkingOccupied1 = value;
        if (!value) {
          timer1 = 0;
          totalCost = 0;
        } else {
          startTimer(1);
        }
        emit(ParkingUpdated());
        break;
      case 2:
        ir2 = value;
        parkingOccupied2 = value;
        if (!value) {
          timer2 = 0;
          totalCost = 0;
        } else {
          startTimer(2);
        }
        emit(ParkingUpdated());
        break;
      case 3:
        ir3 = value;
        parkingOccupied3 = value;
        if (!value) {
          timer3 = 0;
          totalCost = 0;
        } else {
          startTimer(3);
        }
        emit(ParkingUpdated());
        break;
      case 4:
        ir4 = value;
        parkingOccupied4 = value;
        if (!value) {
          timer4 = 0;
          totalCost = 0;
        } else {
          startTimer(4);
        }
        emit(ParkingUpdated());
        break;
    }
  }

  int get minutes {
    switch (activeSpot) {
      case 1:
        return timer1 ~/ 60;
      case 2:
        return timer2 ~/ 60;
      case 3:
        return timer3 ~/ 60;
      case 4:
        return timer4 ~/ 60;
      default:
        return 0;
    }
  }

  int get seconds {
    switch (activeSpot) {
      case 1:
        return timer1 % 60;
      case 2:
        return timer2 % 60;
      case 3:
        return timer3 % 60;
      case 4:
        return timer4 % 60;
      default:
        return 0;
    }
  }

  //payment
  //payment
  AuthenticationRequestModel? authTokenModel;

  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingStates());
    DioHelperPayment.postData(url: ApiContest.getAuthToken, data: {
      'api_key': ApiContest.paymentApiKey,
    }).then((value) {
      authTokenModel = AuthenticationRequestModel.fromJson(value.data);
      ApiContest.paymentFirstToken = authTokenModel!.token;
      print('The token 🍅');
      emit(PaymentAuthSuccessStates());
    }).catchError((error) {
      print('Error in auth token 🤦‍♂️');
      emit(
        PaymentAuthErrorStates(error.toString()),
      );
    });
  }

  Future getOrderRegistrationID({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(PaymentOrderIdLoadingStates());
    DioHelperPayment.postData(url: ApiContest.getOrderId, data: {
      'auth_token': ApiContest.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": (totalCost * 100).toInt().toString(),
      "currency": "EGP",
      "items": [],
    }).then((value) {
      print(totalCost * 100);
      OrderRegistrationModel orderRegistrationModel =
          OrderRegistrationModel.fromJson(value.data);
      ApiContest.paymentOrderId = orderRegistrationModel.id.toString();
      getPaymentRequest((totalCost * 100).toInt().toString(), firstName,
          lastName, email, phone);
      print('The order id =${ApiContest.paymentOrderId}');
      emit(PaymentOrderIdSuccessStates());
    }).catchError((error) {
      print('Error in order id 🤦‍♂️ ${error.response}');
      emit(
        PaymentOrderIdErrorStates(error.toString()),
      );
    });
  }

  // for final request token

  Future<void> getPaymentRequest(
    String priceOrder,
    String firstName,
    String lastName,
    String email,
    String phone,
  ) async {
    emit(PaymentRequestTokenLoadingStates());
    DioHelperPayment.postData(
      url: ApiContest.getPaymentRequest,
      data: {
        "auth_token": ApiContest.paymentFirstToken,
        "amount_cents": priceOrder,
        "expiration": 3600,
        "order_id": ApiContest.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": ApiContest.integrationIdCard,
        "lock_order_when_paid": "false"
      },
    ).then((value) {
      PaymentRequestModel paymentRequestModel =
          PaymentRequestModel.fromJson(value.data);
      ApiContest.finalToken = paymentRequestModel.token;
      print('Final token 🚀 ${ApiContest.finalToken}');
      emit(PaymentRequestTokenSuccessStates());
    }).catchError((error) {
      print('Error in final token 🤦‍♂️ ${error.response}');
      emit(
        PaymentRequestTokenErrorStates(error.toString()),
      );
    });
  }

  Future getRefCode() async {
    DioHelperPayment.postData(
      url: ApiContest.getRefCode,
      data: {
        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR",
        },
        "payment_token": ApiContest.finalToken,
      },
    ).then((value) {
      ApiContest.refCode = value.data['id'].toString();
      print('The ref code ${ApiContest.refCode}');
      emit(PaymentRefCodeSuccessStates());
    }).catchError((error) {
      print("Error in ref code 🤦‍♂️");
      emit(PaymentRefCodeErrorStates(error.toString()));
    });
  }
}
