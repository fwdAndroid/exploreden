import 'dart:typed_data';

import 'package:exploreden/screens/profile/interest_screen.dart';
import 'package:exploreden/services/database_service.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
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
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 59, backgroundImage: MemoryImage(_image!))
                  : Center(
                      child: Image.asset(
                        "assets/face.png",
                        width: 110,
                        height: 110,
                      ),
                    ),
              Positioned(
                  bottom: -10,
                  left: 70,
                  child: IconButton(
                      onPressed: () => selectImage(),
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      )))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 0.2, spreadRadius: 0.5, color: Colors.grey)
                ],
                color: colorWhite,
              ),
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                controller: firstController,
                decoration: InputDecoration(
                  hintText: "First Name",
                  fillColor: colorWhite,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 0.2, spreadRadius: 0.5, color: Colors.grey)
                ],
                color: colorWhite,
              ),
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                controller: lastController,
                decoration: InputDecoration(
                  hintText: "Last Name",
                  fillColor: colorWhite,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 0.2, spreadRadius: 0.5, color: Colors.grey)
                ],
                color: colorWhite,
              ),
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  fillColor: colorWhite,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        fixedSize: const Size(303, 60),
                      ),
                      onPressed: profile,
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

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  void profile() async {
    setState(() {
      _isLoading = true;
    });
    String rse = await DatabaseMethods().profile(
        firstname: firstController.text,
        lastname: lastController.text,
        phone: phoneController.text,
        file: _image!);

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse != 'sucess') {
      showSnakBar(rse, context);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => InterestScreen()));
    }
  }
}
