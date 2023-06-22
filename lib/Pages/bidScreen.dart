/*
import 'package:flutter/material.dart';
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

  Produto(this.created_at, this.category, this.descricao, this.id, this.imagem, this.lance, this.nome, this.tempo, this.lastBid);
}

class bidScreen extends StatefulWidget {
  final usuario;

  const bidScreen({super.key, required this.usuario});

  @override
  State<bidScreen> createState() => _bidScreenState();
}

class _bidScreenState extends State<bidScreen> {
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

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('produtos').get();
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
          data!['lastBid']
        );
      }).toList();

      setState(() {
        allProducts = produtos;
        filteredProducts = List.from(allProducts);
      });
    } catch (e) {
      print('Erro ao buscar produtos: $e');
    }
  }


  infoUser() {}

  AlertDialog(
    title: 
  );


Stream<GyroscopeEvent> gyroscopeEvent
void initState(){
  gyroscopeEvents.listen(
    (GyroscopeEvent event) {
      var x = event.x; //~0
      var y = event.y; //~0
      var z = event.z; //~0
    },
  );
}

gyroscopeEvents.listen(
  (GyroscopeEvent event) {
    print(event);
  },
  onError: (error) {
    // Logic to handle error
    // Needed for Android in case sensor is not available
    },
  cancelOnError: true,
);
// [GyroscopeEvent (x: 0.0, y: 0.0, z: 0.0)]

Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}*/