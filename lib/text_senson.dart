import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profanity/provider/register_provider.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Text_filter extends StatefulWidget {
  const Text_filter({Key? key}) : super(key: key);

  @override
  State<Text_filter> createState() => _Text_filterState();
}

class _Text_filterState extends State<Text_filter> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<RegisterProvider>(context);

      final filter = ProfanityFilter();

    bool hasProfanity = filter.hasProfanity(auth.emailController.text);
    List<String> wordsFound = filter.getAllProfanity(auth.emailController.text);





    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:  Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return Scaffold(
      appBar: AppBar(),
           body: Padding(padding: EdgeInsets.fromLTRB(20, height/3, 20, 0),
        child: Column(
          children: [
            const Text(
              "Enter Text",
              style: TextStyle(
                color: Color(0xff1f1d1d),
                fontSize: 20,
                fontFamily: "Lato",
                fontWeight: FontWeight.w600,
              ),
            ),


            Container(
              width: width,
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: auth.emailController,

                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfffffde7),
                  filled: true,
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
    if (hasProfanity ==true) {
      Fluttertoast.showToast(
          msg: "Profanity detected = ${wordsFound}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
    else
    return null;

    auth.updateText();




            }, child: Text("Submit"))
          ],
        ),
      ),

    );
  }
}

//  final filter = ProfanityFilter();
//
//   //This string contains the profanity 'ass'
//   String badString = 'You are an ass';
//
//   //Check for profanity - returns a boolean (true if profanity is present)
//   bool hasProfanity = filter.hasProfanity(badString);
//   print('The string $badString has profanity: $hasProfanity');
//
//   //Get the profanity used - returns a List<String>
//   print('The string contains the words: $wordsFound');
//
//   //Censor the string - returns a 'cleaned' string.
//   String cleanString = filter.censor(badString);
//   print('Censored version of "$badString" is "$cleanString"');
// }