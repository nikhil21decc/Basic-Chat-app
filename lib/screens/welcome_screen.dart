import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/Components/btb.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController c1;
  Animation a1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c1 = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    a1 = ColorTween(begin: Colors.green[200], end: Colors.white).animate(c1);
    c1.forward();

    c1.addListener(() {
      setState(() {
        print(a1.value);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    c1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: a1.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'h1',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 80,
                  ),
                ),
                TyperAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Rbtn(() {
              Navigator.pushNamed(context, 'ls');
            }, 'Log In', Colors.lightBlueAccent),
            Rbtn(() {
              Navigator.pushNamed(context, 'rs');
            }, 'Register', Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}
