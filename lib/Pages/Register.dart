import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

_saveLogin() async{
  
}

class _RegisterPageState extends State<RegisterPage> {
  bool showRegisterPass = true;
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
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
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
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
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
          TextField(
            keyboardType: TextInputType.text,
            obscureText: showRegisterPass,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              label: const Text(
                'Confirme sua senha',
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
          const Row(
            children: [
               Expanded(
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
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
               SizedBox(
                width: 10,
              ),
               Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
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
          const Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
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
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
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
            height: 35,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(0, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
