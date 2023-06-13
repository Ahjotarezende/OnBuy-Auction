import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({super.key});

  @override
  State<ResetPassPage> createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  Future _resetPass(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  'Email enviado com sucesso!',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                ),
                duration: Duration(seconds: 2),
              )));
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

  final TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(
            15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: const EdgeInsets.only(left: 15, top: 10),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black12,
                  size: 35,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Resetar senha",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) => value!.isEmpty
                              ? "Você deve informar seu email."
                              : null,
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide(color: Colors.purple)),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              label: Text(
                                'Digite seu E-mail',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              hintText: 'E-mail',
                              suffixIconColor: Colors.purple,
                              suffixIcon: Icon(Icons.person_2_outlined)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _resetPass(email.text);
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 20)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.purple)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Enviar confirmação',
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(Icons.arrow_right)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
