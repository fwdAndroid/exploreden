import 'package:exploreden/screens/auth/auth_signup.dart';
import 'package:exploreden/screens/dashboard/main_dashboard.dart';
import 'package:exploreden/services/auth_service.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/controllers.dart';
import 'package:exploreden/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 395,
              height: 439,
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                      blurRadius: 0.2, spreadRadius: 0.5, color: Colors.grey)
                ],
                color: colorWhite,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(150),
                    bottomRight: Radius.circular(150),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/owl.png",
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    "Welcome To Explorer Den",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Enter your email",
                style: TextStyle(
                  color: mainColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                  controller: loginEmailControllers,
                  decoration: InputDecoration(
                    hintText: "Enter Your Email Address ",
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
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 6),
              child: Text(
                "Enter your password",
                style: TextStyle(
                  color: mainColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                  controller: loginPasswordControllers,
                  decoration: InputDecoration(
                    hintText: "Enter Your Password ",
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
            _isloading
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          fixedSize: const Size(303, 60),
                        ),
                        onPressed: signUpUsers,
                        child: Text(
                          "Enter",
                          style: TextStyle(
                              color: colorWhite,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AuthSignUp()));
                },
                child: Text(
                  "Don't Have an account",
                  style: TextStyle(color: mainColor),
                ))
          ],
        ),
      ),
    );
  }

  signUpUsers() async {
    setState(() {
      _isloading = true;
    });
    String rse = await AuthMethods().loginInUser(
      email: loginEmailControllers.text,
      pass: loginPasswordControllers.text,
    );

    print(rse);
    setState(() {
      _isloading = false;
    });
    if (rse != 'sucess') {
      showSnakBar(rse, context);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainDashboard()));
    }
  }
}
