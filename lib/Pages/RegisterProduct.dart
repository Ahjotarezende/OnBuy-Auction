import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:intl/intl.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({Key? key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  List<File?> images = List.generate(3, (_) => null);
  List<String?> imageUrls = List.generate(3, (_) => null);
  String _valorSelect = "3";
  String _valorType = "Gamer";

  Future<void> _register(context, product) async {
    try {
      final docProduct =
          FirebaseFirestore.instance.collection("produtos").doc();
      product["id"] = docProduct.id;
      await docProduct.set(product);
      for (int i = 0; i < images.length; i++) {
        if (images[i] != null) {
          final file = images[i]!;
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('product_images')
              .child(docProduct.id)
              .child('image_$i.jpg');
          await storageRef.putFile(file);
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Anunciado!",
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          e.toString(),
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins"),
        ),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _bidController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                padding: const EdgeInsets.only(top: 10, right: 300),
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
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black45)),
                                label: Text(
                                  'Nome do Produto',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.5),
                                ),
                                hintText:
                                    'Nome que será exibido para os Compradores',
                                hintStyle: TextStyle(fontSize: 13),
                                suffixIconColor: Colors.black45,
                                suffixIcon: Icon(Icons.shopping_bag_outlined)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _descriptionController,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black45)),
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
                          TextFormField(
                            controller: _bidController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black45)),
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
                                suffixIcon:
                                    Icon(Icons.monetization_on_outlined)),
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
                                    value: '24',
                                    child: Text('1 Dia'),
                                  ),
                                ],
                                value: _valorSelect,
                                onChanged: (valor) {
                                  setState(() {
                                    _valorSelect = valor!;
                                    _timeController.text = valor;
                                  });
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Categoria',
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
                                    value: 'Gamer',
                                    child: Text('Gamer'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Casa',
                                    child: Text('Casa'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Celulares',
                                    child: Text('Celulares'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Automóveis',
                                    child: Text('Automóveis'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Roupas',
                                    child: Text('Roupas'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Decoração',
                                    child: Text('Decoração'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Eletrodomésticos',
                                    child: Text('Eletrodomésticos'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Esportes',
                                    child: Text('Esportes'),
                                  ),
                                ],
                                value: _valorType,
                                onChanged: (valor) {
                                  setState(() {
                                    _valorType = valor!;
                                    _typeController.text = valor;
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
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
                    Row(
                      children: [
                        for (int i = 0; i < images.length; i++)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  if (imageUrls[i] == null)
                                    Positioned(
                                      child: SizedBox(
                                        height: 100,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            pickImage(ImageSource.gallery, i);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            backgroundColor: Colors.black12,
                                            side: const BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.add_rounded,
                                              size: 80,
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (imageUrls[i] != null)
                                    Container(
                                      width: 100,
                                      height: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.black12,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: AspectRatio(
                                          aspectRatio: 1.0,
                                          child: Image.file(
                                            File(imageUrls[i]!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _register(
                              context,
                              {
                                "nome": _nameController.text,
                                "descricao": _descriptionController.text,
                                "lance": _bidController.text,
                                "tempo": _timeController.text,
                                "imagem": imageUrls,
                                "Created_at": DateTime.now().toString(),
                                'category': _typeController.text,
                                'lastBid': ''
                              },
                            );
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
                          fixedSize:
                              MaterialStateProperty.all(const Size(200, 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              'Leiloar',
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(Icons.assignment_turned_in_outlined),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage(ImageSource source, int index) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => images[index] = imageTemporary);
    imageUrls[index] = image.path;
  }
}
