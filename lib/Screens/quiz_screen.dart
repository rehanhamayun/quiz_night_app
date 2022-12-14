import 'dart:async';

import 'package:app_kwiz/ProviderController/api_services.dart';
import 'package:app_kwiz/ProviderController/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configs/colors.dart';
import '../configs/texts.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var currentQuestionIndex = 0;
  int seconds = 30;
  Timer? timer;
  late Future quiz;

  int points = 0;
  var rightones = [];
  List<Icon> tick = [];
  List<Icon> cross = [];

  var isLoaded = false;

  var optionsList = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    quiz = getApiData();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataClass>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.red, Colors.orange],
        )),
        child: FutureBuilder(
          future: quiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data["results"];

              if (isLoaded == false) {
                optionsList = data[currentQuestionIndex]["incorrect_answers"];
                optionsList.add(data[currentQuestionIndex]["correct_answer"]);
                optionsList.shuffle();
                isLoaded = true;
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: Colors.lightGreen, width: 2),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  CupertinoIcons.xmark,
                                  color: Colors.white,
                                  size: 22,
                                )),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              normalText(
                                  color: Colors.white,
                                  size: 24,
                                  text: "$seconds"),
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(
                                  value: seconds / 30,
                                  valueColor: const AlwaysStoppedAnimation(
                                      Colors.white),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.addQuestiontoLiked(
                                  data[currentQuestionIndex]["question"]);
                            },
                            child: Container(
                              height: 50,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                // border: Border,
                              ),
                              child: TextButton.icon(
                                  onPressed: null,
                                  icon: const Icon(CupertinoIcons.heart_fill,
                                      color: Colors.black, size: 12),
                                  label: normalText(
                                      color: Colors.black,
                                      size: 12,
                                      text: "Like")),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Image.asset(ideas, width: 200),
                      const SizedBox(height: 20),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: normalText(
                              color: lightgrey,
                              size: 12,
                              text:
                                  "Question ${currentQuestionIndex + 1} of ${data.length}")),
                      const SizedBox(height: 20),
                      normalText(
                          color: Colors.white,
                          size: 16,
                          text: data[currentQuestionIndex]["question"]),
                      const SizedBox(height: 20),

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var answer =
                              data[currentQuestionIndex]["correct_answer"];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (answer.toString() ==
                                    optionsList[index].toString()) {
                                  optionsColor[index] = Colors.green;
                                  rightones.add(answer[index].length);
                                  // TICK CROSS.
                                  tick.add(const Icon(Icons.check));

                                  //points = points + 10;
                                } else {
                                  optionsColor[index] = Colors.red;
                                  cross.add(Icon(Icons.close));
                                }

                                if (currentQuestionIndex < data.length - 1) {
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    isLoaded = false;
                                    currentQuestionIndex++;
                                    resetColors();
                                    timer!.cancel();
                                    seconds = 30;
                                    startTimer();
                                  });
                                } else {
                                  timer!.cancel();
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: size.width - 100,
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              decoration: BoxDecoration(
                                color: optionsColor[index],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: headingText(
                                color: Colors.black,
                                size: 14,
                                text: optionsList[index].toString(),
                              ),
                            ),
                          );
                        },
                      ),

                      headingText(
                          text:
                              "Score: ${rightones.length} out of ${data.length} ",
                          fontWeight: FontWeight.bold,
                          size: 15),
                      const SizedBox(
                        height: 20,
                      ),
                      //RESULTS
                      GestureDetector(
                        onTap: () {
                          showCupertinoDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text("Results"),
                                content: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: tick.length,
                                          itemBuilder: (context, index) {
                                            return const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            );
                                          }),
                                    ),
                                    //
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: cross.length,
                                          itemBuilder: (context, index) {
                                            return const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                scrollController: ScrollController(),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: headingText(
                                color: Colors.black, text: "Results", size: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      )),
    );
  }
}
