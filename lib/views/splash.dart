import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkForToken();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
            child: new Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: FlutterLogo(),
      // new Image(
      //     image: new AssetImage('images/booking.png'))
    )));
  }

  checkForToken() async {
    setState(() {
          Navigator.of(context).pushReplacementNamed('/home');
        });
    
    // FirebaseAuth.instance.currentUser().then((user) {
    //   if (user != null) {
    //     if (user.displayName == null || user.displayName.length == 0) {
    //       Navigator.of(context).pushReplacementNamed("/personal_data");
    //     } else {
    //       Navigator.pushReplacementNamed(context, "/activities");
    //     }
    //   } else {
    //     Navigator.of(context).pushReplacementNamed("/signin");
    //   }
    // }
    // );
  }
}
