// ignore_for_file: file_names, prefer_const_constructors, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Call the function to show user's location when the map page is opened
    showUserLocationOnMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // APPBAR
      appBar: AppBar(
        leading: const Icon(
          Icons.map_outlined,
          color: AppColors.white,
        ),
        title: const Text(
          "Google Map",
          style: TextStyle(
            fontFamily: 'Poppins Regular',
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        backgroundColor: AppColors.buttonColor,
        elevation: 0.0,
        //automaticallyImplyLeading: false,
      ),
      
      // INITIALIZING BODY AS GOOGLE MAP
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 14,
        ),
        onMapCreated: (contrller) {
          _mapController = contrller;
          addMarker('Testing Map', LatLng(0, 0));
        },
        onTap: (coordinate) {
          _mapController.animateCamera(CameraUpdate.newLatLng(coordinate));
          addMarker('User Tapped', coordinate,
              title: 'You Pinned', snip: 'Discover this place');
        },
        markers: _markers.values.toSet(),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onCameraMove: (CameraPosition position) {},
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
          // Current Location Button
          FloatingActionButton(
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.white,
            onPressed: () {
              _markers.clear();
              showUserLocationOnMap();
            },
            child: Icon(Icons.my_location),
          ),
          SizedBox(width: 8),
          
          // Zoom In Map Button
          FloatingActionButton(
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.white,
            onPressed: () {
              _mapController.animateCamera(CameraUpdate.zoomIn());
            },
            child: Icon(Icons.add_circle_rounded),
          ),
          SizedBox(width: 8),
          
          // Zoom Out Map Button 
          FloatingActionButton(
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.white,
            onPressed: () {
              _mapController.animateCamera(CameraUpdate.zoomOut());
            },
            child: Icon(Icons.remove_circle_rounded),
          ),
        ],
      ),
    );
  }

  // FUNCTION TO ADD CUSTOM MARKER
  addMarker(String markId, LatLng location,
      {String title = "User's Current Location",
      String snip = "Your current Location"}) {
    var marker = Marker(
      markerId: MarkerId(markId),
      position: location,
      infoWindow: InfoWindow(
        title: title,
        snippet: snip,
      ),
    );
    _markers[markId] = marker;
    setState(() {});
  }

  // FUNCTION TO SHOW CURRENT USER LOCATION ON MAP
  void showUserLocationOnMap() async {
    LocationData locationData = await getCurrentLocation();
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(locationData.latitude!, locationData.longitude!),
        14,
      ),
    );
    addMarker(
      'User Location',
      LatLng(locationData.latitude!, locationData.longitude!),
    );
  }

  // GETTING USER CURRENT LOCATION
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    return await location.getLocation();
  }
}
