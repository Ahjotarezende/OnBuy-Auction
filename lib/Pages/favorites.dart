import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FavoritePage extends StatefulWidget {
  final usuario;
  const FavoritePage({super.key, required this.usuario});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  infoUser() {}

  @override
  Widget build(BuildContext context) {
    String getBirth(String fullDate) {
      List<String> parts = fullDate.split(' ');
      return parts.first;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
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
                  ),
                ),
                const Text(
                  "Seus Favoritos:",
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('usuarios')
                  .doc(widget.usuario['id'])
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Erro: ${snapshot.error}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  return const Text(
                    'Nenhum item curtido encontrado.',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  );
                }

                List<Map<String, dynamic>> curtidos =
                    List<Map<String, dynamic>>.from((snapshot.data!.data()
                                as Map<String, dynamic>?)?['favoritos']
                            as List<dynamic>? ??
                        []);

                return ListView.builder(
                  itemCount: curtidos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final produto = curtidos[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Nome: ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: produto["nome"],
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Categoria: ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: produto["categoria"],
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Lance Inicial: ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text:
                                    "R\$ ${produto['lanceInicial'].toString()}",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.purple,
                          thickness: 2,
                          height: 25,
                          endIndent: 45,
                        ),
                      ],
                    );
                  },
                );
              },
            ))
          ]),
        ),
      ),
    );
  }
}
