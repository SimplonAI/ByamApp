import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.indigo,
            Colors.purple,
          ],
        ),
      ),
      padding: const EdgeInsets.only(top: 100),
      child: Column(children: [
        const Text(
          'BYAM!',
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 56,
              fontFamily: "cursive",
              color: Colors.white),
        ),
        const Image(image: AssetImage("assets/books.png"), height: 250),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 50),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Text(
            "L'application qui va vous recommander les livres que vous aimez !",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 20,
              color: Colors.white70,
              fontFamily: "roboto",
            ),
            textAlign: TextAlign.center,
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                primary: Colors.white70,
                backgroundColor: Colors.purpleAccent.shade100,
                textStyle: const TextStyle(fontSize: 24)),
            onPressed: () => {Navigator.pushNamed(context, "/register")},
            child: const Text("Inscription"))
      ]),
    );
  }
}
