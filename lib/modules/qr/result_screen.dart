import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/modules/cubit/cubit.dart';
import 'package:parking_app/modules/cubit/states.dart';
import 'package:parking_app/modules/payment/register_integration/register_Integration_screen.dart';
import 'package:parking_app/modules/qr/qr_scanner.dart';
import 'package:parking_app/shared/components/components.dart';
import 'package:parking_app/shared/styles/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {
  final String code;

  final Function() closeScreen;

  const ResultScreen(
      {super.key, required this.closeScreen, required this.code});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingCubit, ParkingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ParkingCubit.get(context);
        if (cubit.ir1 == false)
          cubit.updateSensor(1, !cubit.ir1);
        else if (cubit.ir2 == false)
          cubit.updateSensor(2, !cubit.ir2);
        else if (cubit.ir3 == false)
          cubit.updateSensor(3, !cubit.ir3);
        else if (cubit.ir4 == false) cubit.updateSensor(4, !cubit.ir4);

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                closeScreen();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black87,
              ),
            ),
            titleSpacing: 0.0,
            title: Text(
              "Your Spot",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // QrImageView(
                //   data: code,
                //   size: 150,
                //   version: QrVersions.auto,
                // ),
                // const Text(
                //   "Scanned result",
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.black54,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: 1,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Text(code,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 30)),
                SizedBox(
                  height: 10,
                ),

                CircularPercentIndicator(
                  radius: 140,
                  lineWidth: 10,
                  percent: cubit.totalCost * 0.001,
                  center: Image(
                    height: 230,
                    image: AssetImage('assets/Images/carspot.jpg'),
                  ),
                  progressColor: defaultColor2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  cubit.parkingOccupied1
                      ? cubit.formatTime(cubit.timer1)
                      : "00:00:00",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: defaultColor4, fontSize: 50),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: defaultColor2,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    cubit.parkingOccupied1
                        ? "Cost: \$${cubit.totalCost.toStringAsFixed(2)}"
                        : "Cost: 0.0",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white, fontSize: 30),
                  ),
                ),
                Spacer(),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: defultButton(
                    function: () {
                      navigateAndFinish(context, RegisterIntegrationScreen());
                    },
                    text: 'Pay'.toUpperCase(),
                  ),
                ),

                //  SizedBox(
                //   width: MediaQuery.of(context).size.width - 100,
                //   height: 48,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.blue,
                //     ),
                //     onPressed: () {
                //       Clipboard.setData(ClipboardData(text: code));
                //     },
                //     child: const Text(
                //       "Copy",
                //       style: TextStyle(
                //         fontSize: 16,
                //         letterSpacing: 1,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
