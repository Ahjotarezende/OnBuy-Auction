import 'package:flutter/material.dart';
import 'package:on_buy_auction/Pages/favorites.dart';
import 'package:on_buy_auction/Pages/infos.dart';
import 'package:on_buy_auction/Pages/notify.dart';
import 'package:on_buy_auction/Pages/RegisterProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class HomePage extends StatefulWidget {
  final usuario;

  const HomePage({super.key, required this.usuario});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  void filterByInput(String Name){
    setState(() {
      selectedFilter = 'Todos';
      filteredProducts = allProducts
          .where((produto) => produto.nome.toLowerCase().contains(Name.toLowerCase()))
          .toList();
    });
  }

  void applyFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      if (selectedFilter == "Todos") {
        filteredProducts = allProducts.toList();
      } else {
        filteredProducts = allProducts.where((product) {
          return product.category.contains(filter);
        }).toList();
      }
    });
  }

  Future _saveProduct(Produto produto, String idPessoa) async {
    try {
      await FirebaseFirestore.instance.collection("usuarios")
          .doc(idPessoa)
          .update({
        'favoritos': FieldValue.arrayUnion([{"nome": produto.nome, "lanceInicial": produto.lance, "categoria": produto.category}])
      })
          .then((value) =>
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Adicionado aos favoritos",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins"),
            ),
            duration: Duration(seconds: 2),
          )));
    }catch(e){
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

  ImageProvider getImageProvider(String imagem) {
    if (imagem.startsWith('http')) {
      return NetworkImage(imagem);
    } else {
      return AssetImage(imagem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black12,
          child: ListView(
            padding: const EdgeInsets.only(top: 15, left: 20),
            children: [
              const Text(
                "Os melhores",
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "produtos",
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
              Container(
                padding: const EdgeInsets.only(right: 20),
                child: TextField(
                  controller: _filterController,
                  onChanged: (val)=>filterByInput(val),
                  decoration: const InputDecoration(
                      hintText: "Pesquise",
                      hintStyle: TextStyle(fontSize: 25),
                      suffixIcon: Icon(
                        Icons.search,
                        size: 40,
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        applyFilter(filters[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: filters[index] == selectedFilter
                              ? Colors.black
                              : Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            filters[index],
                            style: TextStyle(
                                color: filters[index] == selectedFilter
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 370,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final produto = filteredProducts[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              produto.nome,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Preço atual",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Poppins",
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "\$${produto.lance}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                "|",
                                style: TextStyle(
                                  color: Colors.black12,
                                  fontSize: 30,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tempo restante",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Poppins",
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "${produto.tempo} ${produto.tempo != '24' ? 'h':'d'}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(90, 50)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                        )),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.purple)),
                                child: const Text(
                                  'Comprar',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _saveProduct(produto, widget.usuario["id"]);
                                },
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: Colors.purple, width: 2)),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(90, 50)),
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                      )),
                                ),
                                child: const Text(
                                  'Salvar',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Poppins",
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.local_fire_department,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterProductPage()));
                      },
                      icon: const Icon(
                        Icons.add_box_outlined,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NotifyPage()));
                      },
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FavoritePage(usuario: widget.usuario)));
                      },
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => InfosPage(usuario: widget.usuario)));
                        },
                        icon: const Icon(
                          Icons.person_outline_rounded,
                          color: Colors.white,
                          size: 33,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
