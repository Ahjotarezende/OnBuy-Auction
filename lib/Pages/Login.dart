import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 45),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/Logo.png',
                width: 45,
                height: 45,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "OnBuy",
                style: TextStyle(
                  fontFamily: "Poppins",
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Auction",
                style: TextStyle(
                    fontFamily: "Poppins",
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 30),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            width: 190,
            child: Text(
              "Compre e Venda em Tempo Real",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
