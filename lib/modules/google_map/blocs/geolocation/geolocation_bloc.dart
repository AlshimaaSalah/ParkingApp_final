// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking_app/modules/google_map/repositories/geolocation/geolocation_repository.dart';

part 'geolocation_event.dart';

part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository geolocationRepository;

  GeolocationBloc({required this.geolocationRepository})
      : super(GeolocationInitial()) {
    on<LoadGeolocation>(_loadGeolocation);
    on<UpdateGeolocation>(_updateGeolocation);
  }

  Future<void> _loadGeolocation(
      LoadGeolocation event, Emitter<GeolocationState> emit) async {
    // emit(GeolocationLoading());
    // final Position position = await geolocationRepository.getCurrentLocation();
    // emit(GeolocationLoaded(position: position));
  }

  Future<void> _updateGeolocation(
      UpdateGeolocation event, Emitter<GeolocationState> emit) async {
    emit(GeolocationLoaded(position: event.position));
  }
}
