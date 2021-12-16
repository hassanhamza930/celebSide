import 'package:celebside/pages/home/celebrityProfile/bookEvent/bookEvent.dart';
import 'package:celebside/util/components.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:celebside/pages/home/celebrityProfile/bookEvent/bookEvent.dart' as bookEvent;
import 'package:location/location.dart';


var initialPos=CameraPosition(target: bookEvent.markerList[0].position,zoom: 15);

class maps extends StatefulWidget {
  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<maps> {



  getPos()async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    return [_locationData.latitude,_locationData.longitude];
  }

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            FutureBuilder(
              future: getPos(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return GoogleMap(
                    mapType: MapType.normal,
                    mapToolbarEnabled: true,
                    compassEnabled: true,
                    initialCameraPosition: CameraPosition(target: LatLng(snapshot.data[0],snapshot.data[1]),zoom: 18),
                    onMapCreated: (GoogleMapController controller) async{

                      // controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(_locationData.latitude,_locationData.longitude))));

                    },
                    onTap: (cords){

                      setState(() {
                        currentLoc=cords;
                        markerList.add(Marker(position: currentLoc,markerId: MarkerId("${currentLoc.toString()}") ));
                        markerList.removeAt(0);
                      });

                    },
                    markers: markerList.toSet(),
                  );
                }
                else{
                  return Container();
                }
              }
            ),
            Container(
              height: height,
              width: width,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: authButton(text: "Done", color: Colors.white, bg: Colors.orange, onPress: (){
                    Navigator.pop(context);
                  }, context: context,thin: true),
                  
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
