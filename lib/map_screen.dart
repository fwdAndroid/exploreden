import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  List<PlaceInfo> _placesInfo = [];

  @override
  void initState() {
    super.initState();
    fetchNearbyPlaces();
  }

  Future<void> fetchNearbyPlaces() async {
    final String apiKey = 'AIzaSyB9ovPkJ-s1cXezeqrQRUxewuWSYNyjdPo';
    final double latitude =
        -33.865143; // Replace with your current location's latitude
    final double longitude =
        151.209900; // Replace with your current location's longitude

    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$latitude,$longitude'
        '&radius=3000'
        '&type=tourist_attraction'
        '&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> results = data['results'];

      for (var place in results) {
        double lat = place['geometry']['location']['lat'];
        double lng = place['geometry']['location']['lng'];
        String name = place['name'];
        String address = place['vicinity'];
        String placeId = place['place_id'];

        _markers.add(
          Marker(
            markerId: MarkerId(name),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: name, snippet: address),
          ),
        );

        // Fetch additional details about the place, including photos
        fetchPlaceDetails(placeId);
      }

      setState(() {});
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<void> fetchPlaceDetails(String placeId) async {
    final String apiKey = 'AIzaSyB9ovPkJ-s1cXezeqrQRUxewuWSYNyjdPo';

    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?'
        'place_id=$placeId'
        '&fields=name,formatted_address,photos'
        '&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> result = data['result'];

      String name = result['name'];
      String address = result['formatted_address'];
      List<dynamic> photos = result['photos'];
      String photoReference = photos[0]['photo_reference'];

      _placesInfo.add(
        PlaceInfo(
          name: name,
          address: address,
          photoReference: photoReference,
        ),
      );

      setState(() {});
    } else {
      throw Exception('Failed to load place details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourist Places Near You'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(33.865143, 151.209900),
                zoom: 15.0,
              ),
              markers: _markers,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _placesInfo.length,
              itemBuilder: (context, index) {
                final placeInfo = _placesInfo[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceDetailScreen(placeInfo),
                      ),
                    );
                  },
                  title: Text(placeInfo.name),
                  subtitle: Text(placeInfo.address),
                  leading: FutureBuilder<Widget>(
                    future: fetchPlacePhoto(placeInfo.photoReference),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!;
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> fetchPlacePhoto(String photoReference) async {
    final String apiKey = 'AIzaSyB9ovPkJ-s1cXezeqrQRUxewuWSYNyjdPo';
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/photo?'
        'maxwidth=100'
        '&photoreference=$photoReference'
        '&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      return Image.memory(response.bodyBytes);
    } else {
      throw Exception('Failed to load place photo');
    }
  }
}

class PlaceInfo {
  final String name;
  final String address;
  final String photoReference;

  PlaceInfo(
      {required this.name,
      required this.address,
      required this.photoReference});
}

class PlaceDetailScreen extends StatelessWidget {
  final PlaceInfo placeInfo;

  PlaceDetailScreen(this.placeInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(placeInfo.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              fetchPlacePhotoUrl(placeInfo.photoReference),
              width: 200,
              height: 150,
            ),
            SizedBox(height: 16.0),
            Text(
              'Name: ${placeInfo.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Address: ${placeInfo.address}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }

  String fetchPlacePhotoUrl(String photoReference) {
    final String apiKey = 'AIzaSyB9ovPkJ-s1cXezeqrQRUxewuWSYNyjdPo';
    return 'https://maps.googleapis.com/maps/api/place/photo?'
        'maxwidth=400'
        '&photoreference=$photoReference'
        '&key=$apiKey';
  }
}
