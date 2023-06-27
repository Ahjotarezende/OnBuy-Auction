import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Produto {
  String nome;
  String descricao;
  String created_at;
  List imagem;
  double lance;
  String tempo;
  String category;
  String id;
  String lastBid;

  Produto(this.created_at, this.category, this.descricao, this.id, this.imagem,
      this.lance, this.nome, this.tempo, this.lastBid);
}

class bidScreen extends StatefulWidget {
  const bidScreen({super.key});

  @override
  State<bidScreen> createState() => _bidScreenState();
}

class _bidScreenState extends State<bidScreen> {
  String productId = '';

  List<Produto> allProducts = [];

  List<Produto> filteredProducts = [];

  List<String> filters = [
    "Todos",
    'Gamer',
    'Casa',
    'Celulares',
    'Automóveis',
    'Roupas',
    'Decoração',
    'Eletrodomésticos',
    'Esportes',
  ];

  String selectedFilter = "";
  final TextEditingController _filterController = TextEditingController();

Future<void> _register(dynamic context) async{ 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Lance Feito!",
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
    }

  double x = 0, y = 0, z = 0;
  String makeBid = "";

  @override
  void initState() {
  gyroscopeEvents.listen(
  (GyroscopeEvent event) {
     x = event.x;
     y = event.y;
     z = event.z;

     if(x + y + z > 2.5){
      makeBid = "S";
     }
  },
  onError: (error) {
    // Logic to handle error
    // Needed for Android in case sensor is not available
    },
  cancelOnError: true,
);
// [GyroscopeEvent (x: 0.0, y: 0.0, z: 0.0)]
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('produtos').get();
      final List<Produto> produtos = snapshot.docs.map((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        return Produto(
            data!['Created_at'],
            data!['category'],
            data!['descricao'],
            data!['id'],
            data!['imagem'],
            double.parse(data!['lance']),
            data!['nome'],
            data!['tempo'],
            data!['lastBid']);
      }).toList();
      setState(() {
        allProducts = produtos;
        filteredProducts = List.from(allProducts);
      });
    } catch (e) {
      print('Erro ao buscar produtos: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 15,),
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
                ),),
              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Leilão",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(90, 50)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                        )),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.purple)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Deseja Fazer Um Lance ?'),
                              content: Text('Para Realizar Um Lance: BALANCE O CELULAR!'),
                              actions: [
                                *
                                ElevatedButton(
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(90, 50)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                        )),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.purple)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Fechar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('LANCE'),
                    ),
                  ],
                )
              ],
            )],
          ),
        ),
      ),
    );
  }
}
