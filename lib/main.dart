import 'package:flutter/material.dart';
import 'package:on_buy_auction/Pages/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sensors_plus/sensors_plus.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const MaterialApp(home: OpeningPage()));
}


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