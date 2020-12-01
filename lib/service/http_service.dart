import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class HttpService {
//  static const String imagesUrl = "https://api.bing.microsoft.com/v7.0/images/search";
  static const String authorizationHeaderName = "Ocp-Apim-Subscription-Key";
  static const String authorizationHeaderValue =
      "50e7821fe35c4bc1a5307c5533bf738d";
  static const int numberOfImages = 30;

  Future<List<Image>> getImages(String search) async {
    try {
      var queryParameters = {
        'q': search,
        'count': numberOfImages.toString(),
      };
      var imagesUrl = Uri.https(
          'api.bing.microsoft.com', '/v7.0/images/search', queryParameters);
      var response = await get(imagesUrl, headers: {
        authorizationHeaderName.toString(): authorizationHeaderValue.toString()
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body)['value'];
        List<Image> result = body.map((e) {
          try {
            return Image.network(
              e["contentUrl"],
              width: 200,
              height: 200,
              alignment: Alignment.centerLeft,
            );
          } catch (exception) {
            print("Can't use image");
            return Image.network("shorturl.at/noqI5");
          }
        }).toList();

        return result;
      }
      return Future.value(List.empty());
    } catch (exception) {
      print("Error during extracting images!");
      return Future.value(List.empty());
    }
  }
}
