import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/main.png",
                      fit: BoxFit.cover,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: colorWhite,
                      ),
                      label: Text(
                        "Lahore",
                        style: TextStyle(color: colorWhite, fontSize: 20),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: ratingColor,
                          ),
                          Text(
                            "4.5",
                            style: TextStyle(color: colorWhite),
                          )
                        ],
                      ),
                      Text("75/230 people Like that place",
                          style: TextStyle(color: colorWhite))
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: const Text(
              'LOCATION DESCRIPTION',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 344,
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Mount Bruno',
                    style: TextStyle(
                      color: Color(0x7F425884),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text:
                        ', lorem ipsum dolor sit amet, consectetur adipiscing elit. Et egestas condimentum vitae maecenas sed est turpis eros.',
                    style: TextStyle(
                      color: Color(0x7F425884),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            child: ListTile(
              leading: Image.asset("assets/loc.png"),
              title: Text(
                "Indonesia",
                style: TextStyle(color: tileColor, fontSize: 10),
              ),
              subtitle: Text(
                "East Java, Indonesia",
                style: TextStyle(
                    color: subTileColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            child: ListTile(
              leading: Image.asset("assets/clock.png"),
              title: Text(
                "Open",
                style: TextStyle(color: tileColor, fontSize: 10),
              ),
              subtitle: Text(
                "09.00 AM",
                style: TextStyle(
                    color: subTileColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Image.asset("assets/map.png")),
        ],
      ),
    );
  }
}
