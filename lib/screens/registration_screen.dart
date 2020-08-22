import 'package:flutter/material.dart';
import 'package:flash_chat/Components/btb.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool b1 = false;
  String em;
  String pw;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: b1,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'h1',
                  child: Container(
                    height: 140.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: ks,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  em = value;
                  //Do something with the user input.
                },
                decoration: kdec.copyWith(
                  hintText: 'Enter your email.',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: ks,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pw = value;
                  //Do something with the user input.
                },
                decoration: kdec.copyWith(
                  hintText: 'Enter your password.',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Rbtn(() async {
                print(em);
                print(pw);
                setState(() {
                  b1 = true;
                });
                try {
                  final n1 = await _auth.createUserWithEmailAndPassword(
                      email: em, password: pw);
                  if (n1 != null) {
                    Navigator.pushNamed(context, 'cs');
                  }
                  setState(() {
                    b1 = false;
                  });
                } catch (e) {
                  print(e);
                }
              }, 'Register', Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
