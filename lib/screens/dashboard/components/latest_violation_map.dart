import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LatestViolationMap extends StatefulWidget {
  static const String route = 'latestViolationMap';

  LatestViolationMap({
    Key? key,
  });

  @override
  State<LatestViolationMap> createState() => _LatestViolationMapState();
}

class _LatestViolationMapState extends State<LatestViolationMap> {
  final PopupController _popupController = PopupController();

  // late List<Marker> markers;
  final Map<String, String> addressCache = {};

  late int pointIndex;
  late StreamController<List<Map<String, dynamic>>> _markersController;
  late Stream<List<Map<String, dynamic>>> _markersStream;
  late List<MapMarkerLatest> markersData;
  final MapController mapController = MapController();
  List<LatLng> points = [
    const LatLng(51.5, -0.09),
    const LatLng(49.8566, 3.3522),
  ];
  Future getData() async {}

  @override
  void initState() {
    _markersController =
        StreamController<List<Map<String, dynamic>>>.broadcast();
    _markersStream = _markersController.stream;
    // getData();
    pointIndex = 0;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _markersController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopupScope(
        popupController: _popupController,
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: LatLng(24.859853436311248, 67.0534506106133),
            initialZoom: 10,
            maxZoom: 17,
            onTap: (_, __) => _popupController
                .hideAllPopups(), // Hide popup when the map is tapped.
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              tileProvider: CancellableNetworkTileProvider(),
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _markersStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                return MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    rotate: true,
                    size: const Size(40, 40),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(50),
                    maxZoom: 17.0,
                    centerMarkerOnClick: true,
                    showPolygon: true,
                    spiderfyCluster: false,
                    onClusterTap: (cluster) {
                      // Get the coordinates of the first marker in the cluster
                      final firstMarker = cluster.markers.first;

                      // Update the map's center and zoom to the coordinates of the first marker
                      _updateMapCenterAndZoom(firstMarker.point, 17.0);
                    },
                    markers: snapshot.data
                            ?.map<Marker>((Map<String, dynamic> markerData) =>
                                markerData['marker'] as Marker)
                            .toList() ??
                        [],
                    polygonOptions: const PolygonOptions(
                        borderColor: Colors.blueAccent,
                        color: Colors.black12,
                        borderStrokeWidth: 3),
                    builder: (context, marker) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 35, 47, 57),
                        ),
                        child: Center(
                          child: Text(
                            marker.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateMapCenterAndZoom(LatLng center, double zoom) {
    // Animate to the new center and zoom
    mapController.move(center, zoom);
  }

  Future<String> getAddress(double lat, double lng) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['display_name'];
    } else {
      throw Exception('Failed to fetch address');
    }
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    final String cacheKey = '${lat},${lng}';

    if (addressCache.containsKey(cacheKey)) {
      return addressCache[cacheKey]!;
    }

    String address;

    try {
      address = await getAddress(lat, lng);
      print('address $address');
      addressCache[cacheKey] = address;
    } catch (e) {
      address = ('Error: $e');
    }

    return address;
  }
}

class MapMarkerLatest {
  final Marker marker;

  MapMarkerLatest({
    required this.marker,
  });
}
