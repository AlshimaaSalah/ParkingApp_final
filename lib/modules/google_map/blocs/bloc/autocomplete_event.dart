// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'autocomplete_bloc.dart';

abstract class AutocompleteEvent extends Equatable {
  const AutocompleteEvent();

  @override
  List<Object> get props => [];

  String get searchInput => '';
}

class LoadAutocomplete extends AutocompleteEvent {
  final String searchInput;
  final String sessiontoken;

  LoadAutocomplete({
    required this.searchInput,
    required this.sessiontoken,
  });

  @override
  List<Object> get props => [searchInput];
}

class GetPlaceDetails extends AutocompleteEvent {
  final String placeId;
  final String sessiontoken;

  GetPlaceDetails({
    required this.placeId,
    required this.sessiontoken,
  });
}
