import 'package:flutter/material.dart';
import 'package:on_buy_auction/Pages/Home.dart';
import 'package:on_buy_auction/Pages/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('Usuário nã está logado!');
    } else {
      print('Usuário está logado!');
    }
  });


class _LoginPageState extends State<LoginPage> {
  bool showPass = true;
  bool emailFocus = false;
  bool passFocus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 115, horizontal: 45),
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
                  fontSize: 30,
                ),
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
          const SizedBox(
            height: 95,
          ),
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(color: Colors.purple)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                label: Text(
                  'Digite seu E-mail',
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.5),
                ),
                hintText: 'E-mail',
                suffixIconColor: Colors.purple,
                suffixIcon: Icon(Icons.person_2_outlined)),
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            keyboardType: TextInputType.text,
            obscureText: showPass,
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(color: Colors.purple)),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                  icon: Icon(
                    showPass ? Icons.visibility_off : Icons.visibility,
                    color: Colors.purple,
                  ),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                label: const Text(
                  'Digite sua senha',
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.5),
                ),
                hintText: 'Senha'),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(0, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Continuar',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: const [
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 2,
                  endIndent: 10,
                ),
              ),
              Text('or'),
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 2,
                  indent: 10,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterPage()));
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(0, 50)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Registrar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.person_2_outlined,
                  color: Colors.purple,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
