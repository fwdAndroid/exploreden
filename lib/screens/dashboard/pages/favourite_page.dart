import 'package:exploreden/screens/destination.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Saved Trips",
          )),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => DestinationPage()));
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/face.png"),
                ),
                trailing: Text(
                  "5.0",
                  style: TextStyle(color: ratingColor, fontSize: 15),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 13,
                        ),
                        Text("Lahore"),
                      ],
                    ),
                  ],
                ),
                title: Text("RedFish Lake"));
          }),
    );
  }
}
