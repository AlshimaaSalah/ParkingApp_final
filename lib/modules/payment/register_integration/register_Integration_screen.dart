import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/modules/cubit/cubit.dart';
import 'package:parking_app/modules/cubit/states.dart';
import 'package:parking_app/modules/payment/payment/payment_ways_screen.dart';
import 'package:parking_app/modules/payment/widgets/show_snack.dart';
import 'package:parking_app/shared/components/components.dart';
import 'package:parking_app/shared/styles/colors.dart';

import '../widgets/default_button.dart';
import '../widgets/default_textformfiled.dart';

class RegisterIntegrationScreen extends StatefulWidget {
  RegisterIntegrationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterIntegrationScreen> createState() =>
      _RegisterIntegrationScreenState();
}

class _RegisterIntegrationScreenState extends State<RegisterIntegrationScreen> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ParkingCubit.get(context).getAuthToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Integration',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocConsumer<ParkingCubit, ParkingStates>(
        listener: (context, state) {
          if (state is PaymentRequestTokenSuccessStates) {
            showSnackBar(
              context: context,
              text: 'Success get final token',
              color: Colors.green,
            );
            navigateAndFinish(context, const PaymentWaysScreen());
          }
        },
        builder: (context, state) {
          var cubit = ParkingCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/Images/payments.png',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DefaultTextFormFiled(
                                controller: firstNameController,
                                type: TextInputType.name,
                                hintText: 'First name',
                                prefix: Icons.person,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your first name!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: DefaultTextFormFiled(
                                controller: lastNameController,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your last name !';
                                  }
                                  return null;
                                },
                                type: TextInputType.name,
                                hintText: 'Last name',
                                prefix: Icons.person,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        DefaultTextFormFiled(
                          controller: emailController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email  !';
                            }
                            return null;
                          },
                          type: TextInputType.emailAddress,
                          hintText: 'Email',
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 10),
                        DefaultTextFormFiled(
                          controller: phoneController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone !';
                            }
                            return null;
                          },
                          type: TextInputType.number,
                          hintText: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 10),
                        // DefaultTextFormFiled(
                        //   controller: priceController,
                        //   validate: (String? value) {
                        //     if (value!.isEmpty) {
                        //       return 'Please enter your price !';
                        //     }
                        //     return null;
                        //   },
                        //   type: TextInputType.number,
                        //   hintText: 'Price',
                        //   prefix: Icons.monetization_on,
                        // ),
                        // Text(cubit.totalCost.toStringAsFixed(2)),
                        const SizedBox(height: 20),
                        DefaultButton(
                          buttonWidget:
                              state is! PaymentRequestTokenLoadingStates
                                  ? Text(
                                      'Register',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              color: Colors.white,
                                              fontSize: 20),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.getOrderRegistrationID(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  price: cubit.totalCost.toString()
                                  //priceController.text,
                                  );
                            }
                          },
                          width: MediaQuery.of(context).size.width,
                          radius: 10.0,
                          backgroundColor: defaultColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
