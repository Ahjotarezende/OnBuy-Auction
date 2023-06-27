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

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  verifyFavorite(Produto produto) {
    return widget.usuario!['favoritos']
        .any((product) => produto.nome == product["nome"]);
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
                  "Comprar",
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Não há notificações para mostrar",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                    )
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
