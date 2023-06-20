import 'package:flutter/material.dart';

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

    String birth = getBirth(widget.usuario['nascimento']);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const Text("Seus Favoritos:", style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.usuario["favoritos"]!.length,
                itemBuilder: (context, index) {
                  final produto = widget.usuario["favoritos"][index];
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
                              text: "R\$ ${produto['lanceInicial'].toString()}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}

/*ListView(
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
"Seus favoritos:",
textAlign: TextAlign.center,
style: TextStyle(
fontSize: 35,
fontFamily: "Poppins",
fontWeight: FontWeight.bold,
),
),
SizedBox(
height: double.infinity,
child: ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: widget.usuario["favoritos"]!.length,
itemBuilder: (context, index) {
final produto = widget.usuario["favoritos"][index];
return Container(
margin: const EdgeInsets.all(8),
padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
child: Column(
children: [
const SizedBox(
height: 30,
),
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
text: 'Lance Inicial: ',
style: TextStyle(
fontSize: 20,
fontFamily: "Poppins",
fontWeight: FontWeight.bold,
color: Colors.black),
),
TextSpan(
text: produto['lanceInicial'],
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
],
),
);
},
),
)
],
),*/