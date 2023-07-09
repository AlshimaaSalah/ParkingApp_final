part of 'autocomplete_bloc.dart';

abstract class AutocompleteState extends Equatable {
  const AutocompleteState();

  @override
  List<Object> get props => [];
}

class AutocompleteLoading extends AutocompleteState {}

class AutocompleteLoaded extends AutocompleteState {
  final List<PlaceAutocomplete> autocomplete;

  const AutocompleteLoaded({required this.autocomplete});

  @override
  List<Object> get props => [autocomplete];
}

class AutocompleteEror extends AutocompleteState {}

class AutocompleteInitial extends AutocompleteState {}

class PlaceDetailsLoading extends AutocompleteState {}

class PlaceDetailsLoaded extends AutocompleteState {
  final PlaceDetailsModel placeDetailsModel;

  const PlaceDetailsLoaded({required this.placeDetailsModel});

  @override
  List<Object> get props => [placeDetailsModel];
}
