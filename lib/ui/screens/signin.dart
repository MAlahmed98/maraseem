import 'package:flutter/material.dart';
import 'package:maraseem/ui/colors/colors.dart';
import 'package:maraseem/ui/components/components.dart';
import 'package:maraseem/ui/screens/home.dart';
import 'package:maraseem/ui/screens/signup.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _Signin();
}

class _Signin extends State<Signin> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [ hexStringToColor("#ffffff"), hexStringToColor("#f2f2f2") ],
        begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
        child: Column(
          children: <Widget>[
            logoWidget("assets/logo/logo.png"),
            SizedBox(
              height: 20
            ),
            textField("Enter UserName", Icons.person_outline, false, _emailTextController),
            SizedBox(
              height: 20,
            ),
            textField("Enter password", Icons.lock_outline , true, _passwordTextController),
            SizedBox(
              height: 20,
            ),
            authButton(context, true, () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home()));
            }),
            signupOption(),
        ])))
        )
    );
  }

  Row signupOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("still don't have an account?",
        style: TextStyle(color: Color.fromARGB(115, 0, 0, 0))),
        GestureDetector(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Signup()));
          },
          child: const Text("  Sign Up!",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )
        )
      ],
    );
  }
}

