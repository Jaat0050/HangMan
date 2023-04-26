import 'package:flutter/material.dart';
import 'package:hangman/game_screen.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Image(
            image: AssetImage("images/name.png"),
          ),
          const Image(
            image: AssetImage("images/gallow.png"),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const GameScreen()));
              },
              child: const Text(
                "START",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
