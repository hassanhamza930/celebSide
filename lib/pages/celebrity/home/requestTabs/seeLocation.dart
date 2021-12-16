
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class seeLocation extends StatefulWidget {

  final double loc_x;
  final double loc_y;
  seeLocation({@required this.loc_x,@required this.loc_y});



  @override
  _seeLocationState createState() => _seeLocationState();
}

class _seeLocationState extends State<seeLocation> {




  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(zoom: 18,target: LatLng(widget.loc_x,widget.loc_y)),
        markers: [ Marker(position: LatLng(widget.loc_x,widget.loc_y),markerId: MarkerId("randomId") ) ].toSet(),
        onMapCreated: (GoogleMapController controller) {
        },

      ),
    );
  }
}
