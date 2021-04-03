//import 'package:SolarApp/Screens/Login/components/authenticate.dart';
import 'package:SolarApp/Screens/home/home.dart';
import 'package:SolarApp/Screens/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SolarApp/Screens/Login/components/background.dart';
import 'package:SolarApp/Screens/Signup/signup_screen.dart';
import 'package:SolarApp/components/already_have_an_account_acheck.dart';
import 'package:SolarApp/components/rounded_button.dart';
import 'package:SolarApp/components/rounded_input_field.dart';
import 'package:SolarApp/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  
  const Body({
    Key key,
  }) : super(key: key);
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (email) {},
            ),
            RoundedPasswordField(
              onChanged: (pass) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                setState(() {
    _isSigningIn = true;
  });

  User user =
      await Authentication.signInWithGoogle(context: context);

  setState(() {
    _isSigningIn = false;
  });

  if (user != null) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Home(
          //user: user,
        ),
      ),
    );
  }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
}
