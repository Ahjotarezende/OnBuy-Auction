import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  Future _register(context, user) async{
    final docUser = FirebaseFirestore.instance.collection("usuarios").doc();
    user["id"] = docUser.id;
    docUser.set(user);
    Navigator.of(context).pop();
  }

  bool showRegisterPass = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nascController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 15),
        children: [
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
          TextField(
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
          TextField(
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
          TextField(
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
                  showRegisterPass ? Icons.visibility_off : Icons.visibility,
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
                child: TextField(
                  controller: _nascController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
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
                child: TextField(
                  controller: _cpfController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
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
                child: TextField(
                  controller: _streetController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
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
                child: TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
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
          TextField(
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
          TextField(
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
              final user = {
                "id": "",
                "name": _nameController.text,
                "email": _emailController.text,
                "password": _passController.text,
                "cpf": _cpfController.text,
                "nascimento": DateFormat('dd/MM/yyyy').parse(_nascController.text),
                "rua": _districtController.text,
                "numeroCasa": _numberController.text,
                "bairro": _districtController.text,
                "saldo": _moneyController.text
              };
              _register(context, user);
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
    );
  }
}
