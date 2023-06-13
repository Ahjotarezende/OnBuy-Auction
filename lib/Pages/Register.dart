import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future _register(context, user, password) async {
    try {
      final date =
          DateFormat("dd/MM/yyyy").parse(BirthMask.getMaskedText()).toString();
      user["nascimento"] = date;
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user["email"], password: password);
      String userId = userCredential.user!.uid;
      user['id'] = userId;
      final docUser = FirebaseFirestore.instance.collection("usuarios").doc(userId);
      await docUser.set(user);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Cadastrado!",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins"),
        ),
        duration: Duration(seconds: 2),
      ));
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      print(e.toString());
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

  final formKey = GlobalKey<FormState>();

  bool showRegisterPass = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  var CPFMask = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var BirthMask = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Registro:',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 35,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Informe seu nome" : null,
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      label: Text(
                        'Nome completo',
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      suffixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Informe seu email" : null,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      label: Text(
                        'Digite seu E-mail',
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      suffixIcon: Icon(
                        Icons.mark_email_unread_outlined,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty
                        ? "Informe sua senha"
                        : value!.length < 6
                            ? "Senha fraca"
                            : null,
                    controller: _passController,
                    keyboardType: TextInputType.text,
                    obscureText: showRegisterPass,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      label: const Text(
                        'Digite sua senha',
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showRegisterPass = !showRegisterPass;
                          });
                        },
                        icon: Icon(
                          showRegisterPass
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Informe seu nascimento." : null,
                          inputFormatters: [BirthMask],
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            hintText: "(dd/MM/yyyy)",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            label: Text(
                              'Data de nascimento',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple)),
                            suffixIcon: Icon(
                              Icons.date_range_outlined,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) => value!.isEmpty
                              ? "Informe seu CPF."
                              : value!.length < 10
                                  ? "CPF Inválido"
                                  : null,
                          inputFormatters: [CPFMask],
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            label: Text(
                              'CPF',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple)),
                            suffixIcon: Icon(
                              Icons.fact_check_outlined,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Informe sua rua." : null,
                          controller: _streetController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            label: Text(
                              'Rua',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple)),
                            suffixIcon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) => value!.isEmpty
                              ? "Informe o número da casa."
                              : null,
                          controller: _numberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            label: Text(
                              'Número',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple)),
                            suffixIcon: Icon(
                              Icons.home,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Informe seu bairro." : null,
                    controller: _districtController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      label: Text(
                        'Bairro',
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      suffixIcon: Icon(
                        Icons.location_city_rounded,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Informe seu saldo." : null,
                    controller: _moneyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      label: Text(
                        'Saldo na conta',
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      suffixIcon: Icon(
                        Icons.monetization_on,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _register(context, {
                          "id": "",
                          "nome": _nameController.text,
                          "email": _emailController.text,
                          "cpf": CPFMask.getMaskedText(),
                          "nascimento": BirthMask.getMaskedText(),
                          "rua": _streetController.text,
                          "numeroCasa": _numberController.text,
                          "bairro": _districtController.text,
                          "saldo": _moneyController.text
                        }, _passController.text);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "Há algo de errado!",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Criar conta',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.check_rounded)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
