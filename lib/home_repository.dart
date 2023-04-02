import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:profanity/utils/url.dart';

class HomeRepository {


  // Future<String> ImageCheck(String link) async {
  //   final url = Uri.parse('https://nsfw-images-detection-and-classification.p.rapidapi.com/adult-content');
  //   print(url);
  //   print(link);
  //
  //   try {
  //     final response = await http.post(url,
  //       headers: <String, String>{
  //       'content-type': 'application/json',
  //       'X-RapidAPI-Key': 'a737b134f7msh1d4adca4dcd40a6p1d2495jsnc804a0569f52',
  //       'X-RapidAPI-Host': 'nsfw-images-detection-and-classification.p.rapidapi.com'
  //     },
  //        body: {
  //       "url":link
  //        },
  //
  //
  //
  //     );
  //
  //     print(url);
  //
  //     return response.body;
  //   } catch (error) {
  //     throw (error);
  //   }
  // }


  Future<String> ImageCheck(String link) async {
    final url = Uri.parse('https://nsfw-images-detection-and-classification.p.rapidapi.com/adult-content');
    print(url);
    try {
      final response = await http.post(url,
          headers: <String, String>{
          'Content-Type': 'application/json',
            'X-RapidAPI-Key': 'a737b134f7msh1d4adca4dcd40a6p1d2495jsnc804a0569f52',
            'X-RapidAPI-Host': 'nsfw-images-detection-and-classification.p.rapidapi.com'
          },
          body: jsonEncode(<String, String>{
            "url":link
          }));

      print(url);

      return response.body;
    } catch (error) {
      throw (error);
    }
  }

}
