import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 Location location = new Location();
 late bool _serviceEnabled;
 late PermissionStatus _permissionGranted;
 late LocationData _locationData;
 late String latitude ="",longitude ="";

 initLocation()async{
  _serviceEnabled =await location.serviceEnabled();
  if (!_serviceEnabled){
    _serviceEnabled = await location.requestService();

    if(!_serviceEnabled){
      return;
    }
  }
  _permissionGranted = await location.hasPermission();
  if(_permissionGranted == PermissionStatus.denied){
    _permissionGranted =await location.requestPermission();
    if(_permissionGranted != PermissionStatus.granted){
      return;
    }
  }
 _locationData = await location.getLocation();

 latitude = _locationData.latitude.toString();
 longitude = _locationData.longitude.toString();

 location.enableBackgroundMode(enable: true);
 location.onLocationChanged.listen((LocationData currentLocation) {});
 

 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLocation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Widget'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Latitude:-" + latitude),
            SizedBox(height: 30,),
            Text("Longitude:-" + longitude),
          ],
        ),
      ),
    );
  }
}