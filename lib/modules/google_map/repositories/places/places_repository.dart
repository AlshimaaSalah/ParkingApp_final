import '../../maps_services.dart';
import '../../models/place_autocomplete_model.dart';

class PlacesRepository {
  final MapsServices mapsServices;

  PlacesRepository(this.mapsServices);

  Future<List<PlaceAutocomplete>> getAutocomplete(
      String searchInput, String sessiontoken) async {
    return await mapsServices.getSuggestions(searchInput, sessiontoken);
  }

  getPlaceDetails(String placeId, String sessiontoken) async {
    return await mapsServices.getPlaceDetailsByPlaceId(placeId, sessiontoken);
  }
}
