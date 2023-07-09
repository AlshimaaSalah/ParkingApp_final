// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:parking_app/modules/cubit/cubit.dart';
import 'package:parking_app/modules/cubit/states.dart';
import 'package:parking_app/modules/services/spot.dart';
import 'package:parking_app/shared/components/components.dart';
import 'package:parking_app/shared/styles/colors.dart';

class ParkingScreen extends StatelessWidget {
  const ParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingCubit, ParkingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // ignore: unused_local_variable
        var cubit = ParkingCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Parking Details',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),

          // resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/Images/p4.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'ESMART',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 20),
                          ),
                        ),
                        const Icon(
                          Icons.star_sharp,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star_sharp,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star_sharp,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 20, color: Colors.grey),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                              'Faculty of Engineering,Al_azhar University',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.subtitle1
                              //.copyWith(color: Colors.grey),
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text('10 LE',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: defaultColor2, fontSize: 18)),
                        Expanded(
                            child: Text(
                          ' /per hour',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Colors.grey),
                        )),
                        const SizedBox(
                          width: 30,
                        ),
                        const Icon(
                          Icons.local_parking_rounded,
                          size: 15,
                          color: Colors.grey,
                        ),
                        Text(
                          '4 spot available',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: defaultTextButton2(
                      text: 'call',
                      function: () {},
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: defaultTextButton2(
                      text: 'Map',
                      function: () {},
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    // Expanded(child: defaultTextButton2(text: 'Save', function: (){},))
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Spacer(),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: defultButton(
                    function: () {
                      // Get.to
                      navigateAndFinish(context, SpotScreen());
                      // navigateAndFinish(
                      //   context,
                      //   const NumberScreen(),
                      //   // ReverseScreen(),
                      //   // SpotScreen(),
                      // );
                    },
                    text: 'Garage view'.toUpperCase(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
