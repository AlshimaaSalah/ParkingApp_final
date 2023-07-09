import 'package:dio/dio.dart';

import 'models/place_autocomplete_model.dart';
import 'models/place_details_model.dart';

class MapsServices {
  final Dio dio;

  MapsServices(this.dio);

  Future<List<PlaceAutocomplete>> getSuggestions(
    String input,
    String sessiontoken,
  ) async {
    try {
      const baseUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';

      final res = await dio.get(
        baseUrl,
        queryParameters: {
          'input': input,
          'key': 'AIzaSyCF2nEat70fOA9CMmdoUvdm7GfCL4wWTNA',
          'sessiontoken': sessiontoken,
          'language': 'ar',
        },
      );
      final data = res.data;

      final suggestions = List<PlaceAutocomplete>.from(
          data['predictions'].map((e) => PlaceAutocomplete.fromJson(e)));

      print('========' * 50);
      print(suggestions);
      print('========' * 50);

      return suggestions;
    } catch (e) {
      print('========' * 50);
      print(e);
      print('========' * 50);
      return [];
    }
  }

  Future<PlaceDetailsModel> getPlaceDetailsByPlaceId(
    String placeId,
    String sessiontoken,
  ) async {
    try {
      const baseUrl = 'https://maps.googleapis.com/maps/api/place/details/json';

      final res = await dio.get(
        baseUrl,
        queryParameters: {
          'place_id': placeId,
          'key': 'AIzaSyCW704ruCIle1YsZUONENzQ2Ao1TIt6DEE',
          'fields': 'formatted_address,name,geometry',
          'sessiontoken': sessiontoken,
          'language': 'ar',
          // 'language' :
        },
      );
      final data = res.data;
      print(data);
      print(placeId);

      final placeDetails = PlaceDetailsModel.fromMap(data['result']);
      return placeDetails;
    } catch (e) {
      rethrow;
    }
  }
}
