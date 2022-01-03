import 'dart:io';

import 'package:camera/camera.dart';
import 'package:celebside/pages/celebrity/home/celebrityVideoFinalize.dart';
import 'package:celebside/util/components.dart';
import 'package:image_picker/image_picker.dart';
import 'celebrityVideoSendSuccessful.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:path_provider/path_provider.dart';
import "package:path/path.dart" as p;


CameraController controller;
List<CameraDescription> cameras;

var currentCam=0;
var isPressed=false;
var finalPath;
var initialized=false;



class celebrityVideoRecord extends StatefulWidget {

  final String reqId;
  celebrityVideoRecord({@required this.reqId});


  @override
  _celebrityVideoRecordState createState() => _celebrityVideoRecordState();
}

class _celebrityVideoRecordState extends State<celebrityVideoRecord> {


  oneTime()async{
    cameras = await availableCameras();
    controller = CameraController(cameras[currentCam], ResolutionPreset.high);
    await controller.initialize().then((value){
      setState(() {
        initialized=true;
      });
    });

    return 0;
  }



  @override
  void initState() {
    isPressed=false;
    currentCam=0;
    oneTime();
    super.initState();
  }


  @override
  void dispose() {
    controller=null;
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          initialized==true && controller!=null?
          AspectRatio(
          aspectRatio: controller.value.aspectRatio,
            child: Container(
                child: Center(
                    child: CameraPreview(
                      controller,
                    )
                )
            ),
          ):
          Container(),
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              alignment: Alignment.bottomCenter,
              height: height,
              width: width,
              child: Container(
                height: 90,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: ()async{

                      },
                        child: Container()
                    ),
                    TextButton(
                      onPressed: ()async{


                        if(isPressed==false){
                          setState(() {
                            isPressed= true;
                          });

                          await controller.initialize();


                          try{
                            final Directory appDirectory = await getExternalStorageDirectory();
                            final String videoDirectory = '${appDirectory.path}/Videos';
                            await Directory(videoDirectory).create(recursive: true);
                            final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
                            finalPath = '$videoDirectory/${currentTime}.mp4';
                            print("created the directory");
                          }
                          catch(e){
                            print(e.message);
                          }


                          await controller.startVideoRecording(finalPath);
                          setState(() {

                          });
                        }

                        else{
                          await controller.stopVideoRecording();

                          setState(() {
                            isPressed=false;
                          });
                          print('stopped');
                          print(finalPath);

                          Navigator.push(context, CupertinoPageRoute(builder: (context){
                          return celebrityVideoFinalize(finalPath:finalPath,reqId: widget.reqId,);
                          }));
                        }




                      },
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              isPressed==true?Colors.red:Colors.white,
                              BlendMode.srcATop
                          ),
                          child: Image.asset(
                            "assets/videoPlayer/buttonBack.png",
                          )
                      ),
                    ),
                    isPressed==true?TextButton(
                      onPressed: (){},
                      child: Container(),
                    ):TextButton(
                        onPressed: ()async{


                          if(currentCam==0){
                          setState(() {
                            currentCam=1;
                            controller = CameraController(cameras[currentCam], ResolutionPreset.high);
                          });
                          await controller.initialize();
                          setState(() {

                          });
                          }
                          else{

                            setState(() {
                              currentCam=0;
                              controller = CameraController(cameras[currentCam], ResolutionPreset.high);
                            });
                            await controller.initialize();
                            setState(() {

                            });
                          }



                        },
                        child: Icon(Icons.rotate_right,color: Colors.white,)
                    ),

                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 40),
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              )),
        ],
      )
    );
  }
}
