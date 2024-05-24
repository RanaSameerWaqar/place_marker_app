import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.55800000, 74.35071000),
    zoom: 14,
  );

  Set<Marker> _markers = {}; // Updated to Set to allow adding and removing markers
  late GoogleMapController _mapController;

  int _currentIndex = 0;
  bool _messageExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Marker App'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.satellite,
            compassEnabled: false,
            myLocationEnabled: true,
            markers: _markers,
            onTap: _onMapTap, // Handle tap to add a marker
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _mapController = controller;
            },
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: _messageExpanded ? 16.0 : -100.0,
            left: 16.0,
            right: 16.0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _messageExpanded = !_messageExpanded;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'This app is created by "Rana Sameer Waqar" registration Number "2021-ag-9376"',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNextMarker,
        child: Icon(Icons.location_disabled_outlined),
      ),
    );
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _messageExpanded = false;
    });
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Label'),
                onSubmitted: (value) {
                  setState(() {
                    _markers.add(
                      Marker(
                        markerId: MarkerId('${_markers.length + 1}'),
                        position: position,
                        infoWindow: InfoWindow(
                          title: value,
                        ),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          Random().nextDouble() * 360,
                        ),
                      ),
                    );
                  });
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNextMarker() {
    if (_markers.isNotEmpty) {
      if (_currentIndex < _markers.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      Marker marker = _markers.elementAt(_currentIndex);
      _mapController.animateCamera(CameraUpdate.newLatLng(marker.position));
    }
  }
}
