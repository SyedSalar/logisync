import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController _mapController = MapController();
  LatLng _currentLocation = LatLng(0, 0);
  late StreamSubscription<Position> _positionStreamSubscription;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startFetchingLocation();
  }

  @override
  void dispose() {
    super.dispose();
    _positionStreamSubscription?.cancel();
  }

  void _startFetchingLocation() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings:
          LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 10),
    ).listen((Position position) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false; // Update isLoading flag once location is fetched
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching location
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter:
                    _currentLocation, // Set center to current location
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  tileProvider: CancellableNetworkTileProvider(),
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation,
                      child: SvgPicture.asset(
                        'assets/icons/truck.svg',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
