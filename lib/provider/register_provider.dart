import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profanity/home_repository.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class NsfwDetectionProvider with ChangeNotifier {
  static const baseUrl =
      'https://nsfw-images-detection-and-classification.p.rapidapi.com/api/json';
  final _headers = <String, String>{
    'Content-Type': 'application/json',
    'X-RapidAPI-Key': 'a737b134f7msh1d4adca4dcd40a6p1d2495jsnc804a0569f52',
    'X-RapidAPI-Host': 'nsfw-images-detection-and-classification.p.rapidapi.com'
  };

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<NsfwDetectionResult> _results = [];
  List<NsfwDetectionResult> get results => _results;

  Future<void> detectNsfw(String url) async {
    _isLoading = true;
    notifyListeners();
    final lur = Uri.parse('https://nsfw-images-detection-and-classification.p.rapidapi.com/adult-content');
    print(url);


    final response = await http.post(lur,
      headers: _headers,
      body: jsonEncode(<String, String>{'url': url}),
    );

    _results = [];
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      final predictions = List<Map<String, dynamic>>.from(decodedData['objects']);

      predictions.forEach((prediction) {
        final result = NsfwDetectionResult(
          label: prediction['label'],
          score: prediction['score'].toDouble(),
        );
        _results.add(result);
      });
    } else {
      throw Exception('Failed to load NSFW detection results');
    }


    _isLoading = false;
    notifyListeners();
  }
}

class NsfwDetectionResult {
  final String label;
  final double score;

  NsfwDetectionResult({required this.label, required this.score});
}

class contentModel with ChangeNotifier {
  contentModel({
    required this.score,
    required this.label,
  });

  double score;
  String label;

}

class RegisterProvider with ChangeNotifier {
  bool result = false;
  final HomeRepository _homeRepo = HomeRepository();
  HomeRepository get homeRepo => _homeRepo;
  String cityName = "Select City";
  String instituteName = 'Select Institute';
  final TextEditingController _nameController = TextEditingController();

  TextEditingController get nameController => _nameController;
  final TextEditingController _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;
  String profileImage = '';
  String user = 'Teacher';
  String city_id = "0";
  String institude_id = "0";
  bool instituteNameError = false;
  bool city_idError = false;
  bool nameError = false;
  bool emailError = false;
  bool cityNameError = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<contentModel> _Items = [];

  List<contentModel> get Items {
    return [..._Items];
  }


  void updateText() {
    emailController.text = "";
    notifyListeners();
  }



  void updateUserType(String value) {
    user = value;
    notifyListeners();
  }

  uploadProfileImage(String filepath) async {
    profileImage = filepath;
    notifyListeners();
  }
  givepath(String filepath,BuildContext context) async {
    profileImage = filepath;
    notifyListeners();
    giveImage(context);
  }




  giveImage(BuildContext context) async {
    _Items = [];

      await _homeRepo
          .ImageCheck(
        profileImage
      )
          .then((response) async {
        final responseData = json.decode(response);
        print(responseData);
     //   bool result = responseData['unsafe'];
        print(result);
        responseData['objects'].forEach((prodData) {
          _Items.add(contentModel(label: prodData['label'], score: prodData['score']));
        });

      });
    }
    notifyListeners();
  }

  void _showDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('!'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size.fromHeight(40.0)),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            child: const Text('Okay'),
            onPressed: () {


              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

