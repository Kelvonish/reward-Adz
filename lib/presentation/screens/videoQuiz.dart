import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_view/quiz_view.dart';

class VideoQuiz extends StatefulWidget {
  @override
  _VideoQuizState createState() => _VideoQuizState();
}

class _VideoQuizState extends State<VideoQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Video Questions"),
      ),
      body: Center(
          child: QuizView(
        image: Container(
          width: 150,
          height: 150,
          child: Image.network(
              "https://yt3.ggpht.com/a/AATXAJyPMywRmD62sfK-1CXjwF0YkvrvnmaaHzs4uw=s900-c-k-c0xffffffff-no-rj-mo"),
        ),
        showCorrect: true,
        tagBackgroundColor: Colors.deepOrange,
        tagColor: Colors.black,
        questionTag: "Question: 2",
        answerColor: Colors.white,
        answerBackgroundColor: Color.fromARGB(255, 255, 0, 111),
        questionColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 111, 0, 255),
        width: 300,
        height: 600,
        question: "Which is the best framework for app development?",
        rightAnswer: "Flutter",
        wrongAnswers: ["Fluttor", "Flitter"],
        onRightAnswer: () => print("Right"),
        onWrongAnswer: () => print("Wrong"),
      )),
    );
  }
}
