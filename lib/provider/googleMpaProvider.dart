import 'dart:convert';
import 'package:dispatch_app_rider/src/lib_export.dart';
import 'package:dispatch_app_rider/utils/constants.dart';
import 'package:http/http.dart' as http;

class GoogleMapProvider with ChangeNotifier {
  Future<List> getSuggestions(String query, String sessionToken) async {
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = 'establishment';
    String apiKey = Constant.apiKey;
    String url =
        '$baseUrl?input=$query&key=$apiKey&type=$type&language=en&components=country:ng&sessiontoken=$sessionToken';
    print('Autocomplete(sessionToken): $sessionToken');
    final http.Response response = await http.get(url);
    final responseData = json.decode(response.body);
    final predictions = responseData['predictions'];
    List<Place> suggestions = [];
    for (int i = 0; i < predictions.length; i++) {
      final place = Place.fromJson(predictions[i]);
      suggestions.add(place);
    }

    return suggestions;
  }

  Future<PlaceDetail> getPlaceDetail(
      String placeId, String sessionToken) async {
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/place/details/json';
    String apiKey = Constant.apiKey;
    String url =
        '$baseUrl?key=$apiKey&place_id=$placeId&language=en&sessiontoken=$sessionToken';
    print('Place Detail(sessionToken): $sessionToken');
    final http.Response response = await http.get(url);
    final responseData = json.decode(response.body);
    final result = responseData['result'];

    final PlaceDetail placeDetail = PlaceDetail.fromJson(result);
    print(placeDetail.toMap());

    return placeDetail;
  }
}
