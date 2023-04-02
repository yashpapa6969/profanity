import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profanity/provider/register_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import 'dart:io';

class Image_sensor extends StatefulWidget {
  const Image_sensor({Key? key}) : super(key: key);

  @override
  State<Image_sensor> createState() => _Image_sensorState();
}

class _Image_sensorState extends State<Image_sensor> {
  @override
  Widget build(BuildContext context) {
    List<String> images = ["https://i0.wp.com/www.zorg.video/wp-content/uploads/2020/03/Maya-Hawke-nude-niople-and-mild-sex-Marisa-Tomei-sexy-Human-Capital-2019-HD-1080p-010.jpg",
    "https://i.ebayimg.com/images/g/xPwAAOSwRgpiubFL/s-l1600.jpg",
      "https://media.vogue.co.uk/photos/5d54530e086e2d0008676e45/master/pass/jack-oconnell-brick-cat-on-a-hot-tin-roof-photographer-credit-johan-persson.jpg",
      "https://danielfreemanphotography.co.uk/images/OK1A0109B+W.jpg",
      
    ];




    final reg = Provider.of<RegisterProvider>(context);
    final ImagePicker _picker = ImagePicker();
//     uploadImage() async {
//       final _firebaseStorage = FirebaseStorage.instance;
//       final _imagePicker = ImagePicker();
//       PickedFile? image;
//       //Check Permissions
//
//
//
//         //Select Image
//         image = await _imagePicker.getImage(source: ImageSource.gallery);
//
//
//         if (image != null) {
//           print('Selected image: ${image.path}');
//
//           var file = File(image.path);
//
//           List<int> imageBytes = await file.readAsBytes();
//
// // Create a reference to the Firestore collection where you want to store the image
//           FirebaseFirestore firestore = FirebaseFirestore.instance;
//           CollectionReference imagesRef = firestore.collection('images');
//
//
// // Create a document reference for the new image document
//           String imageName = path.basename(file.path);
//           DocumentReference imageDocRef = imagesRef.doc(imageName);
//
// // Upload the bytes of the image file to Cloud Firestore
//           imageDocRef.set({
//             'imageBytes': imageBytes,
//           }).then((value) {
//             print('Image uploaded to Cloud Firestore');
//           }).catchError((error) {
//             print('Failed to upload image to Cloud Firestore: $error');
//           });
//
//
//
//
//
//
//     }
//
//     }
      void _settingModalBottomSheet() {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext bc) {
              return SizedBox(
                height: 150,
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: const Icon(Icons.camera),
                        title: const Text('Camera'),
                        onTap: () async {
                          Navigator.pop(context);
                          final pickedFile = await _picker.pickImage(
                              source: ImageSource.camera,
                              maxHeight: 500,
                              maxWidth: 500,
                              imageQuality: 50);


                          // reg.uploadProfileImage(pickedFile!.path);
                        }),
                    ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text('Gallery'),
                      onTap: () async {
                        Navigator.pop(context);
                        final pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 500,
                            maxWidth: 500,
                            imageQuality: 50);


                        //reg.uploadProfileImage(pickedFile!.path);
                      },
                    ),
                  ],
                ),
              );
            });
      }


      double height = MediaQuery
          .of(context)
          .size
          .height;
      double width = MediaQuery
          .of(context)
          .size
          .width;
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        //color set to transperent or set your own color
        statusBarIconBrightness: Brightness.dark,
        //set brightness for icons, like dark background light icons
      ));
      return Scaffold(
        appBar: AppBar(),
        body: Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [

              const Text(
                "Select The NSFW Image",
                style: TextStyle(
                  color: Color(0xff1f1d1d),
                  fontSize: 20,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w600,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: images.length,
                padding: const EdgeInsets.only(left: 10),
                itemBuilder: (BuildContext context, int i) {
                  return Row(children: [
                    GestureDetector(
                        onTap: () {
                          //reg.givepath(images[i],context);
                          Provider.of<NsfwDetectionProvider>(context, listen: false)
                              .detectNsfw(images[i]);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Details()));



                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                                width: width*0.40,
                                image: Image.network(images[i])
                                    .image,
                                fit: BoxFit.fitHeight))),
                  ]);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10,
                ),
              ),


            ],
          ),
        ),
      );
    }
  }
  class Details extends StatefulWidget {
    const Details({Key? key}) : super(key: key);

    @override
    State<Details> createState() => _DetailsState();
  }

  class _DetailsState extends State<Details> {
    static var _isInit = true;

    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      if (_isInit) {
        //Provider.of<NsfwDetectionProvider>(context, listen: false).(context);

        setState(() {
          _isInit = false;
        });
      }
    }

    @override
    void dispose() {
      setState(() {
        _isInit = true;
      });

      super.dispose();
    }


    @override
    Widget build(BuildContext context) {
      
      double height = MediaQuery
          .of(context)
          .size
          .height;
      double width = MediaQuery
          .of(context)
          .size
          .width;
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        //color set to transperent or set your own color
        statusBarIconBrightness: Brightness.dark,
        //set brightness for icons, like dark background light icons
      ));
      final reg  = Provider.of<RegisterProvider>(context);
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text("Images Nudity contents"),
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: reg.Items.length,
            //   itemBuilder: (context, index) {
            //     return Column(
            //       children: [
            //
            //
            //         Text(reg.Items[index].label, ),
            //         Text(reg.Items[index].score.toString()),
            //
            //
            //       ],
            //
            //    );
            //   },
            // )
            Consumer<NsfwDetectionProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (provider.results.isEmpty) {
                  return Container();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: provider.results.length,
                      itemBuilder: (context, index) {
                        final result = provider.results[index];
                        return ListTile(
                          title: Text(result.label),
                          subtitle: Text('Score: ${result.score}'),
                        );
                      },
                    ),
                  );
                }
              },
            ),


          ],
        ),
      );
    }
  }




