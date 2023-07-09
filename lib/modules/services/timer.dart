import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/modules/cubit/cubit.dart';
import 'package:parking_app/modules/cubit/states.dart';
import 'package:parking_app/modules/payment/register_integration/register_Integration_screen.dart';
import 'package:parking_app/modules/qr/qr_scanner.dart';
import 'package:parking_app/shared/components/components.dart';
import 'package:parking_app/shared/styles/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingCubit, ParkingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ParkingCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    navigateTo(context, QRScanner());
                  },
                ),
                Text(
                  'Your Spot',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 140,
                  lineWidth: 10,
                  percent: 0.8,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
