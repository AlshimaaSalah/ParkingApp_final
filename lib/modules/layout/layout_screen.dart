import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:parking_app/modules/cubit/cubit.dart';
import 'package:parking_app/modules/cubit/states.dart';
import 'package:parking_app/shared/styles/colors.dart';

import '../login/auth_controller.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingCubit, ParkingStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = ParkingCubit.get(context);
        return Scaffold(
          drawer: Drawer(
            child: GetBuilder<AuthControllers>(
              builder: (controller) => ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        // image:DecorationImage(
                        //     image: AssetImage('assets/Images/x4.png'),
                        //     fit: BoxFit.cover,colorFilter: ColorFilter.linearToSrgbGamma()
                        // )
                        color: defaultColor),
                    // currentAccountPicture:Image(image:AssetImage('assets/Images/x3.png',),fit: BoxFit.cover,),
                    accountName: const Text('Maha Farghaly'),
                    accountEmail: const Text('maha@gmail.com'),
                    currentAccountPicture: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/Images/girl.jpg'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const ListTile(
                    leading: Icon(Icons.brightness_4),
                    title: Text('Theme Mode'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notifications'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Help'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.login_outlined),
                    title: const Text('Log Out'),
                    onTap: () {
                      controller.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),

          // appBar: AppBar(
          //   title: Text(
          //     cubit.titles[cubit.currentIndex],
          //     // style: TextStyle(
          //     // //  color: Theme.of(context).appBarTheme.titleTextStyle.color,
          //     // ),
          //   ),

          // ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_parking), label: ''),
            ],
          ),
        );
      },
    );
  }
}
