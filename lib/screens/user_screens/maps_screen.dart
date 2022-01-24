import 'dart:async';

import 'package:e_commerce1/constants.dart';
import 'package:e_commerce1/providers/address_provider.dart';
import 'package:e_commerce1/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  static String routeName = "/maps";
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  //addressNotifier addressNotify = addressNotifier();
  GoogleMapController? _controller;
  loc.Location currentLocation = loc.Location();
  Set<Marker> _markers={};
  late StreamSubscription<loc.LocationData> locationSubscription;

  void getLocation(BuildContext screenContext) async{
    final addressListener = Provider.of<addressNotifier>(context, listen: false);
    var location = await currentLocation.getLocation();
    print("location"+location.toString());
    locationSubscription = currentLocation.onLocationChanged.listen((loc.LocationData loc) async {

      _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
        zoom: 12.0,
      )));
      print(loc.latitude);
      print(loc.longitude);

      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(loc.latitude!,loc.longitude!);
      //print(placemarks.first.street);
      //print(placemarks.first.country);
      //print(placemarks.first.administrativeArea);
      //print(placemarks.first.subAdministrativeArea);
      addressListener.updateAddress(placemarks.first.street!,
          placemarks.first.country!,placemarks.first.administrativeArea!,loc.longitude!,loc.longitude!);
      //print(placemarks.first.);



      setState(() {
        _markers.add(Marker(markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
        ));
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('disposed');
    locationSubscription.cancel();
    super.dispose();
  }
  @override
  void initState(){
    super.initState();

    setState(() {
      getLocation(super.context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final addressListener = Provider.of<addressNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition:CameraPosition(
            target: LatLng(30.0444, 31.2357),
            zoom: 12.0,
          ),
          onMapCreated: (GoogleMapController controller){
            _controller = controller;
          },
          markers: _markers,
        ) ,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching,color: Colors.white,),
        onPressed: (){
          getLocation(context);
        },
      ),
        bottomNavigationBar:Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(15),
            horizontal: getProportionateScreenWidth(30),
          ),
          // height: 174,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.add_reaction,
                          size: 12,
                          color: kTextColor,
                        )
                    ),
                    Spacer(),
                    Text(addressListener.address == null ?   "...":addressListener.address!.street),

                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kTextColor,
                    ),
                    TextButton(
                      child: const Text('Pick'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        //clearText();
                      },
                    ),
                  ],
                ),

              ],
            ),
          ),
        )
    );
  }
}