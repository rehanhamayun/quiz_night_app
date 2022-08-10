import 'package:app_kwiz/Screens/quiz_screen.dart';
import 'package:app_kwiz/configs/texts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Image.asset(
              "assets/images/test.png",
              height: 270,
              width: 270,
            ),
          ),
          SizedBox(
            height: 70,
          ),
          headingText(
            text: "Grab your friends",
            size: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 20,
          ),
          normalText(
              text:
                  "Invite your friends to a battle \n of wits. The Smartest Wins!",
              size: 18,
              color: Colors.grey.withOpacity(0.7)),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuizScreen()));
            },
            child: Container(
              height: 80,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: normalText(
                  text: "Start Quiz",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
