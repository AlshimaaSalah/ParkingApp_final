// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_app/modules/payment/register_integration/register_Integration_screen.dart';
import 'package:parking_app/shared/styles/colors.dart';

Widget defaultAppBar({
  required BuildContext context,
  required Widget widget,
  required String title,
}) =>
    AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              navigateTo(context, widget);
            },
          ),
          Text(
            title,
            style: Theme.of(context).appBarTheme.titleTextStyle!,
          ),
        ],
      ),
    );

Widget defultTextButton({
  required String text,
  required VoidCallback function,
  required Color color,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color),
      ),
    );

Widget defaultTextButton2({
  required String text,
  required VoidCallback function,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(defaultColor2),
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.4)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
    );

Widget defultButton({
  double width = double.infinity,
  //Color background = Colors.blue,
  required VoidCallback function,
  required String text,
  bool isUpperCase = true,
  double radius = 0.0,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          color: defaultColor, borderRadius: BorderRadius.circular(radius)),
    );

Widget defultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  VoidCallback? onSubmit,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit != null ? (value) => onSubmit() : null,
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ))
            : null,
      ),
      onTap: onTap,
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );

void navigateTo(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (route) => false);

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      // timeToLive: Duration(seconds: 25),
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget defaultDatePicker(BuildContext context,
        {required cubit, required String text}) =>
    Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!,
          ),
          MaterialButton(
            onPressed: () {
              cubit.datePicker(context);
            },
            child: Text('${cubit.selectDate}'),
            color: Colors.blueAccent.withOpacity(0.4),
          ),
        ],
      ),
    );

Widget defaultTimePicker(BuildContext context,
        {required cubit, required String text}) =>
    Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!,
          ),
          MaterialButton(
            onPressed: () {
              cubit.timePicker(context);
            },
            child: Text('${cubit.selectTime}'),
            color: Colors.grey.withOpacity(0.001),
          ),
        ],
      ),
    );

Widget selectSpot(BuildContext context,
        {required bool cubit,
        required String image,
        required String spotName}) =>
    Expanded(
      child: Row(
        children: [
          const Expanded(
              child: Icon(
            Icons.arrow_downward_outlined,
            color: Colors.grey,
            size: 40,
          )),
          Expanded(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.blueAccent.withOpacity(0.1),
                child: Center(
                  child: cubit
                      ? RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            spotName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Colors.grey,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                          ),
                        )
                      : Image(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          image: AssetImage(image)),
                )),
          ),
        ],
      ),
    );

class ParkingSpot extends StatelessWidget {
  final String spotNumber;
  final bool occupied;
  final String time;
  final String cost;
  final VoidCallback onTap;

  const ParkingSpot({
    required this.spotNumber,
    required this.occupied,
    required this.time,
    required this.cost,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: occupied ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Spot $spotNumber",
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 10),
            Text(
              time,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 25),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: AlignmentDirectional.center,
              //height: 120,
              width: 200,
              decoration: BoxDecoration(
                  color: defaultColor3,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                cost,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: defaultColor, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
