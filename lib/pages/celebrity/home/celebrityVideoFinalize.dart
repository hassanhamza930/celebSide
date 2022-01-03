import 'dart:io';

import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/services/addToWallet.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart' show rootBundle;

VideoPlayerController _controller;


Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}


class celebrityVideoFinalize extends StatefulWidget {
  final String finalPath;
  final reqId;
  celebrityVideoFinalize({@required this.finalPath,@required this.reqId});

  @override
  _celebrityVideoFinalizeState createState() => _celebrityVideoFinalizeState();
}

class _celebrityVideoFinalizeState extends State<celebrityVideoFinalize> {




  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
        File(widget.finalPath)
        )
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;



    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: [
            _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : Container(),
            Center(
                child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                      backgroundColor: Colors.orange,
                      child: FaIcon(
                        FontAwesomeIcons.download,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: ()async {

                        showLoading(context: context);
                        final result = await ImageGallerySaver.saveFile(widget.finalPath);
                        print("printing result");
                        print(result);

                        Navigator.pop(context);
                        showMessage(context: context, message: "Saved in Gallery");




                      }),
                  SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton(
                      backgroundColor: Colors.orange,
                      child: FaIcon(
                        FontAwesomeIcons.arrowRight,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: ()async {


                        try{
                          showLoading(context: context);
                          DocumentSnapshot doc=await FirebaseFirestore.instance.collection("requests").doc(widget.reqId).get();
                          Map data=doc.data();

                          var user=data["user"];
                          var amount=data["amount"];
                          var celebData= await getCelebrityData(id: FirebaseAuth.instance.currentUser.uid);
                          var celebName=celebData["fullName"];


                          await FirebaseStorage.instance.ref("requests/${widget.reqId}/${FirebaseAuth.instance.currentUser.uid}").putFile(File(widget.finalPath))
                              .then((TaskSnapshot taskSnapshot) {
                            if (taskSnapshot.state == TaskState.success) {
                              print("Image uploaded Successful");
                              taskSnapshot.ref.getDownloadURL().then(
                                      (imageURL)async {

                                    await FirebaseFirestore.instance.collection("requests")
                                        .doc(widget.reqId)
                                        .set(
                                        {
                                          "vidSrc":imageURL,
                                          "status":"complete"
                                        },
                                        SetOptions(merge: true));





                                   await addNotifications(
                                       target: "user",
                                       message: "${celebName} has replied to a video request.",
                                       from: FirebaseAuth.instance.currentUser.uid,
                                       to: user,
                                       type: "videoRequest"
                                   );


                                   await addTransaction(
                                       message: "Video Request",
                                       to: FirebaseAuth.instance.currentUser.uid,
                                       from: user,
                                       amount: double.parse("${amount*0.7}").floorToDouble()
                                   );

                                   await addToWallet(amount: double.parse("${amount*0.7}").floorToDouble(), id: FirebaseAuth.instance.currentUser.uid, type: "celebrities");

                                  });




                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              showMessage(context: context, message: 'Congratulations! You have successfully recieved ${double.parse("${amount*0.7}").floorToDouble()} GHS');

                            }
                            else if (taskSnapshot.state == TaskState.running) {
                            }
                            else if (taskSnapshot.state == TaskState.error) {
                              Navigator.pop(context);
                              showErrorDialogue(context: context, message: TaskState.error.toString());
                            }
                          });
                        }

                        catch(e){
                          Navigator.pop(context);
                          showErrorDialogue(context: context, message: e);
                        }



                      }),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                  child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 20),
                      width: width,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ))),
            ),
            GestureDetector(
              onTap: ()async{
                print('forces');
                await _controller.play();
              },
              child: Container(
                height: height,
                width: width,
                child: Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
