import 'package:flutter/material.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  String _valorSelect = "3";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                )),
            Container(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Anuncie seu",
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "produto",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.purple,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45)),
                        label: Text(
                          'Nome do Produto',
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.5),
                        ),
                        hintText: 'Nome que será exibido para os Compradores',
                        hintStyle: TextStyle(fontSize: 13),
                        suffixIconColor: Colors.black45,
                        suffixIcon: Icon(Icons.shopping_bag_outlined)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45)),
                        label: Text(
                          'Descrição do produto',
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.5),
                        ),
                        hintText: 'Características e estado do produto',
                        hintStyle: TextStyle(fontSize: 13),
                        suffixIconColor: Colors.black45,
                        suffixIcon: Icon(Icons.description_outlined)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45)),
                        label: Text(
                          'Lance inicial',
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.5),
                        ),
                        hintText: 'Valor mínimo',
                        hintStyle: TextStyle(fontSize: 13),
                        suffixIconColor: Colors.black45,
                        suffixIcon: Icon(Icons.monetization_on_outlined)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Tempo disponível',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.black45,
                      ),
                      const SizedBox(width: 20),
                      DropdownButton<String>(
                        items: const [
                          DropdownMenuItem<String>(
                            value: '3',
                            child: Text('3 Horas'),
                          ),
                          DropdownMenuItem<String>(
                            value: '6',
                            child: Text('6 Horas'),
                          ),
                          DropdownMenuItem<String>(
                            value: '12',
                            child: Text('12 Horas'),
                          ),
                          DropdownMenuItem<String>(
                            value: '1',
                            child: Text('1 Dia'),
                          ),
                        ],
                        value: _valorSelect,
                        onChanged: (valor) {
                          setState(() {
                            _valorSelect = valor!;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Inserir imagens",
                    style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 140,
                      height: 140,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black12,
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 80,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(const Size(200, 50)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                          backgroundColor: MaterialStateProperty.all(Colors.purple)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Leiloar',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.assignment_turned_in_outlined)
                        ],
                      ),
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
