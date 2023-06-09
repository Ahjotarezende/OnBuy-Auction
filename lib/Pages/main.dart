import 'package:flutter/material.dart';
import 'package:on_buy_auction/Pages/Login.dart';

class OpeningPage extends StatelessWidget {
  const OpeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/OpeningPage.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 50),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
                        shape: MaterialStatePropertyAll(CircleBorder()),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: OpeningPage()));
}
