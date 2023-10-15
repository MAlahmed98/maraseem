import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maraseem/ui/colors/colors.dart';
import 'package:maraseem/ui/components/components.dart';
import 'package:maraseem/ui/screens/home.dart';
import 'package:maraseem/ui/screens/verify.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  TextEditingController countryCode = TextEditingController();
  String _verificationCode= '';
  var phone ="";
  TextEditingController _phoneTextController = TextEditingController();

  @override
  void initState() {
    countryCode.text = "+973";
    super.initState();
  }

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
            TextField(
              controller: _phoneTextController,
            onChanged: (number){
              phone = number;
            }, 
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone, color: Colors.black),
            labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
            hintText: "Phone Number",
            )
            ),
            SizedBox(
              height: 20
            ),
            authButton(context, false, () async{
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: '+973${phone}',
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {
                  print(e.message);
                },
                codeSent: (String verificationId, int? resendToken) {
                  setState(() {
                    _verificationCode = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (String verificationId) {
                  setState(() {
                    _verificationCode= verificationId;
                  });
                },
                timeout: Duration(seconds: 60)
              );
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyVerify()));
            },),
            signinOption(),
        ])))
        )
    );
  }

  Row signinOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
        style: TextStyle(color: Color.fromARGB(115, 0, 0, 0))),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text("  Sign In",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )
        )
      ],
    );
  }
}