import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_app/modules/google_map/repositories/places/places_repository.dart';

import '../../models/place_autocomplete_model.dart';
import '../../models/place_details_model.dart';

part 'autocomplete_event.dart';

part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository placeRepository;

  AutocompleteBloc({required this.placeRepository})
      : super(AutocompleteInitial()) {
    on<LoadAutocomplete>(_loadAutocomplete);
    on<GetPlaceDetails>(_getPlaceDetails);
  }

  Future<void> _loadAutocomplete(
    LoadAutocomplete event,
    Emitter<AutocompleteState> emit,
  ) async {
    emit(AutocompleteLoading());
    final List<PlaceAutocomplete> autocomplete = await placeRepository
        .getAutocomplete(event.searchInput, event.sessiontoken);
    emit(AutocompleteLoaded(autocomplete: autocomplete));
  }

  FutureOr<void> _getPlaceDetails(
      GetPlaceDetails event, Emitter<AutocompleteState> emit) async {
    emit(PlaceDetailsLoading());
    final result = await placeRepository.getPlaceDetails(
        event.placeId, event.sessiontoken);
    emit(PlaceDetailsLoaded(placeDetailsModel: result));
  }
}
