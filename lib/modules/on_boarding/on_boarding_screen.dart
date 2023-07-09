// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_app/modules/login/phone.dart';
import 'package:parking_app/shared/components/components.dart';
import 'package:parking_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../dataBaseCaching.dart';
import '../login/auth_controller.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    // BoardingModel(
    //     image: 'assets/Images/x1.png',
    //     title: 'Look',
    //     body: 'Find Parking Spot in the Address,City or State'),
    BoardingModel(
        image: 'assets/Images/x22.jpg',
        title: 'LOOK',
        body: 'Find Parking Spot in the Address,City or State'),
    BoardingModel(
        image: 'assets/Images/x33.jpg',
        title: 'Enjoy',
        body: 'Locate a car in the place you park your vehicle')
  ];
  bool isLast = false;

  void submit() {
    authControllers.isOnbord.value = true;
    baseCaching.addDataCache(
      'onBoarding',
      true,
    );
    //Todo: this should be called asynchronously

    Get.offAll(const MyPhone());
    // CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    //   if (value) {
    //     navigateAndFinish(context, LayoutScreen()
    //         //MyPhone()
    //         );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      //print('last');
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      //print('not last');
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                      controller: boardController,
                      effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: defaultColor,
                          spacing: 5,
                          dotWidth: 10,
                          dotHeight: 10,
                          expansionFactor: 4),
                      count: boarding.length),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                onPressed: () {
                  if (isLast == true) {
                    submit();
                  }

                  boardController.nextPage(
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                child: const Text('GO'),
              ),
              const SizedBox(
                height: 15,
              ),
              defultTextButton(
                text: 'SKIP',
                color: Colors.grey,
                function: () {
                  submit();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Image(image: AssetImage('${model.image}'))),
        const SizedBox(
          height: 30,
        ),
        Text(
          '${model.title.toUpperCase()}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          '${model.body}',
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
