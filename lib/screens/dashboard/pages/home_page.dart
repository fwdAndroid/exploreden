import 'dart:convert';

import 'package:exploreden/map_screen.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/filter.png", height: 20, width: 30),
          )
        ],
        title: Image.asset(
          "assets/owl.png",
          height: 40,
          width: 40,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _placesInfo.length,
              itemBuilder: (context, index) {
                final placeInfo = _placesInfo[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) =>
                                PlaceDetailScreen(placeInfo)));
                  },
                  child: Stack(
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder<Widget>(
                          future: fetchPlacePhoto(placeInfo.photoReference),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data!;
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: 30,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              placeInfo.name,
                              style: TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("I dont like that place")));
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              FloatingActionButton(
                backgroundColor: mainColor,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("I liked that place")));
                },
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
            ],
          )
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
      return Align(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.memory(
              response.bodyBytes,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      );
    } else {
      throw Exception('Failed to load place photo');
    }
  }
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
              width: MediaQuery.of(context).size.width,
              filterQuality: FilterQuality.high,
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
