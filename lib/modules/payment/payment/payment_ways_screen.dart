import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/modules/cubit/cubit.dart';
import 'package:parking_app/modules/cubit/states.dart';
import 'package:parking_app/modules/payment/payment/ref_code_screen.dart';
import 'package:parking_app/modules/payment/payment/visa_screen.dart';
import 'package:parking_app/modules/payment/register_integration/register_Integration_screen.dart';
import 'package:parking_app/modules/payment/widgets/show_snack.dart';
import 'package:parking_app/shared/components/components.dart';
import 'package:parking_app/shared/components/constants.dart';

class PaymentWaysScreen extends StatelessWidget {
  const PaymentWaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkingCubit(),
      child: BlocConsumer<ParkingCubit, ParkingStates>(
        listener: (context, state) {
          if (state is PaymentRefCodeSuccessStates) {
            showSnackBar(
              context: context,
              text: "Success get ref code ",
              color: Colors.amber.shade400,
            );
            navigateAndFinish(context, const ReferenceScreen());
          }
          if (state is PaymentRefCodeErrorStates) {
            showSnackBar(
              context: context,
              text: "Error get ref code ",
              color: Colors.red,
            );
          }
        },
        builder: (context, state) {
          var cubit = ParkingCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () {
                      navigateAndFinish(context, RegisterIntegrationScreen());
                    },
                  ),
                  Text(
                    'Payment Ways',
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.getRefCode();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.yellow.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.black87, width: 2.0),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: NetworkImage(AppImages.refCodeImage),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Payment with Ref code',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        navigateAndFinish(context, const VisaScreen());
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.yellow.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.black, width: 2.0),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: NetworkImage(AppImages.visaImage),
                            ),
                            Text(
                              'Payment with visa',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
