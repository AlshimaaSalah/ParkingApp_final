// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:parking_app/modules/google_map/blocs/geolocation/geolocation_bloc.dart';
// import 'package:parking_app/modules/google_map/repositories/geolocation/geolocation_repository.dart';
// import 'package:parking_app/modules/google_map/repositories/places/places_repository.dart';
// import 'Home.dart';
// import 'blocs/bloc/autocomplete_bloc.dart';
// import 'blocs/geolocation/bloc_observer.dart';
// import 'maps_services.dart';

// void main() {
//   Bloc.observer = MyBlocObserver();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiRepositoryProvider(
//         providers: [
//           RepositoryProvider<GeolocationRepository>(
//             create: (_) => GeolocationRepository(),
//           ),
//           RepositoryProvider<PlacesRepository>(
//             create: (_) => PlacesRepository(MapsServices(Dio())),
//           ),
//         ],
//         child: MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (context) => GeolocationBloc(
//                   geolocationRepository: context.read<GeolocationRepository>()),
//             ),
//             BlocProvider(
//               create: (context) => AutocompleteBloc(
//                   placeRepository: context.read<PlacesRepository>()),
//             )
//           ],
//           child: MaterialApp(
//             theme: ThemeData(
//               appBarTheme: AppBarTheme(
//                 backgroundColor: Colors.deepPurple,
//               ),
//             ),
//             debugShowCheckedModeBanner: false,
//             home: Home(),
//           ),
//         ));
//   }
// }
