import 'package:exploreden/screens/profile/interest_screen.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/textformfield.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile Details",
          style: TextStyle(color: colorBlack),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/face.png",
              width: 110,
              height: 110,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormInputField(
              controller: firstController,
              hintText: "First Name",
              textInputType: TextInputType.text),
          const SizedBox(
            height: 15,
          ),
          TextFormInputField(
              controller: lastController,
              hintText: "Last Name",
              textInputType: TextInputType.text),
          const SizedBox(
            height: 15,
          ),
          TextFormInputField(
              controller: phoneController,
              hintText: "Phone Number",
              textInputType: TextInputType.number),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  fixedSize: const Size(303, 60),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => InterestScreen()));
                },
                child: Text(
                  "Confrim",
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
