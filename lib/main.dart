import 'package:flutter/material.dart';
import 'package:on_buy_auction/Pages/Login.dart';


//Banco de Dados
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';



Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const MaterialApp(home: OpeningPage()));
}


//Storage
final storage = FirebaseStorage.instance;


/*
void setData(String nome, String valor) {
var db = FirebaseFirestore. instance;
print("dados: $nome $valor ");

db
.collection( "users")
.add(<String, dynamic>{"nome": nome, "valor": valor}).then(
(DocumentReference doc) =>
print( 'DocumentSnapshot added with ID: ${doc.id}'));
}
*/


class OpeningPage extends StatelessWidget {
  const OpeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/OpeningPage.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 50),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
                        shape: MaterialStatePropertyAll(CircleBorder()),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
void main() {
  runApp(const MaterialApp(home: OpeningPage()));
}
*/
