import 'package:flutter/material.dart';
import 'package:hangman/utilities.dart';

import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String word = wordslist[Random().nextInt(wordslist.length)];
  List guessedalphabets = [];
  int points = 0;
  int status = 0;
  List images = [
    "images/0.png",
    "images/1.png",
    "images/2.png",
    "images/3.png",
    "images/4.png",
    "images/5.png",
    "images/6.png",
  ];

  opendialog(String title) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 180,
            decoration: const BoxDecoration(color: Colors.deepPurpleAccent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: retrostyle(20, Colors.white, FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Your Points: $points",
                  style: retrostyle(25, Colors.white, FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        status = 0;
                        guessedalphabets.clear();
                        points = 0;
                        word = wordslist[Random().nextInt(wordslist.length)];
                      });
                    },
                    child: Center(
                      child: Text(
                        "Play Again",
                        style: retrostyle(20, Colors.black, FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String handleText() {
    String displayword = "";
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (guessedalphabets.contains(char)) {
        displayword += "$char ";
      } else {
        displayword += "? ";
      }
    }
    return displayword;
  }

  checkletter(String alphabet) {
    if (word.contains(alphabet)) {
      setState(() {
        guessedalphabets.add(alphabet);
        points += 5;
      });
    } else if (status != 6) {
      setState(() {
        status += 2;
        points -= 5;
      });
    } else {
      opendialog("You Lost !");
    }

    bool isWon = true;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!guessedalphabets.contains(char)) {
        setState(() {
          isWon = false;
        });
        break;
      }
    }
    if (isWon) {
      opendialog("Hurray, you won");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        elevation: 60,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Hangman",
          style: retrostyle(40, Colors.deepPurpleAccent, FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3.99,
                height: 30,
                decoration: const BoxDecoration(color: Colors.white),
                child: Center(
                  child: Text(
                    "$points points",
                    style: retrostyle(15, Colors.black, FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Image(
                width: 200,
                height: 200,
                image: AssetImage(images[status]),
                fit: BoxFit.cover,
                color: Colors.deepPurpleAccent,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "${7 - status} lives left",
                style: retrostyle(18, Colors.white, FontWeight.w700),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                handleText(),
                style: retrostyle(35, Colors.deepPurpleAccent, FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 20),
                childAspectRatio: 1.3,
                children: letters.map(
                  (alphabet) {
                    return InkWell(
                      onTap: () => checkletter(alphabet),
                      child: Center(
                        child: Text(
                          alphabet,
                          style: retrostyle(30, Colors.white, FontWeight.w700),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
