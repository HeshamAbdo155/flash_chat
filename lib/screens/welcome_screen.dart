import 'package:flash_chat/components/welcome_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const String id = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      // lowerBound: 2.0,
      // upperBound: 100.0,
    );
    // animation = CurvedAnimation(
    //   //Must be from 0.0 to 1.0
    //   parent: controller!,
    //   curve: Curves.decelerate,
    // );
    controller!.forward();
    //  controller!.reverse(from: 1.0);

    // animation!.addStatusListener((status) {
    //  if(status==AnimationStatus.completed){
    //    controller!.reverse(from: 1.0);
    //  }else if(status==AnimationStatus.dismissed){
    //    controller!.forward();
    //  }
    // });
    animation = ColorTween(
      begin: Colors.red,
      end: Colors.lightBlue,
    ).animate(controller!);
    controller!.addListener(() {
      setState(() {});
      // print(animation!.value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value, //red.withOpacity(controller!.value),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: 80.0, //controller!.value //animation!.value * 100
                  ),
                ),
                DefaultTextStyle(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Flash Chat'),
                      //${controller!.value.toInt()} %
                    ],
                  ),
                  style: const TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            WelcomeButton(
              colour: Colors.lightBlueAccent,
              name: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            WelcomeButton(
              colour: Colors.blueAccent,
              name: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
