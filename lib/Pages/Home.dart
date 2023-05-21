import 'package:flutter/material.dart';

class Produto {
  String nome;
  String imagem;
  double valor;
  int dias;

  Produto(this.nome, this.imagem, this.valor, this.dias);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Produto> allProducts = [
    Produto("Produto 1", "assets/images/Produto1.jpg", 50, 1),
    Produto("Produto 2Produto 2Produto 2Produto 2",
        "assets/images/Produto2.jpg", 51, 2),
    Produto("Produto 3", "assets/images/Produto3.jpg", 52, 3),
    Produto("Produto 4", "assets/images/Produto4.jpg", 53, 4),
    Produto("Produto 5", "assets/images/Produto5.jpg", 54, 5),
    Produto("Produto 6", "assets/images/Produto6.jpg", 55, 6),
    Produto("Produto 7", "assets/images/Produto7.jpg", 56, 7),
    Produto("Produto 8", "assets/images/Produto8.jpg", 57, 8),
    Produto("Produto 9", "assets/images/Produto9.jpg", 58, 9),
    Produto("Produto 10", "assets/images/Produto10.jpg", 59, 10),
  ];

  List<Produto> filteredProducts = [];

  List<String> filters = [
    "Todos",
    'Produto 1',
    'Produto 2',
    'Produto 3',
    'Produto 5',
    'Produto 6',
    'Produto 7',
    'Produto 8',
    'Produto 9',
    'Produto 10',
  ];

  String selectedFilter = "";

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(allProducts);
  }

  void applyFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      if (selectedFilter == "Todos") {
        filteredProducts = allProducts.toList();
      } else {
        filteredProducts = allProducts.where((product) {
          return product.nome.contains(filter);
        }).toList();
      }
    });
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
                child: const TextField(
                  decoration: InputDecoration(
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
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                              image: DecorationImage(
                                image:
                                    AssetImage(filteredProducts[index].imagem),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              filteredProducts[index].nome,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "\$${filteredProducts[index].valor}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                              const Text(
                                "|",
                                style: TextStyle(
                                    color: Colors.black12, fontSize: 30),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tempo restante",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Poppins",
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "${filteredProducts[index].dias} d",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
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
                                onPressed: () {},
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_box_outlined,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
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
