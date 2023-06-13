import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_buy_auction/Pages/Home.dart';
import 'package:on_buy_auction/Pages/Register.dart';
import 'package:on_buy_auction/Pages/resetPass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future _login(email, senha) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
      String userId = userCredential.user!.uid;
      usuario = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .get();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(usuario: usuario.data())));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          e.toString(),
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins"),
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }

  bool showPass = true;
  var usuario;
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) =>
                  value!.isEmpty ? "Informe um email" : null,
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
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
                TextFormField(
                  validator: (value) => value!.isEmpty
                      ? "Informe sua senha"
                      : value!.length < 6
                      ? "Senha deve ser maior que 6"
                      : null,
                  controller: senha,
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
                    formKey.currentState!.validate()
                        ? _login(email.text, senha.text)
                        : ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        "Confira suas informações de login!",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                      duration: Duration(seconds: 2),
                    ));
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.purple)),
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
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ResetPassPage()));
                  },
                  child: const Text('Esqueceu sua senha?', style: TextStyle(color: Colors.purple),),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
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
