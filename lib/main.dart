import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pointList_1 = [];
    var pointList_2 = [];
    var signature;
    //SignatureController signatureController = SignatureController();
    //signature =  signatureController.;
    SignatureController signatureController = SignatureController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Signature Test"),
        ),
        body: Column(
          children: [
            Material(
              shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.blue, width: 2)),
              child: Signature(
                controller: signatureController = SignatureController(onDrawEnd: () {
                  signature = signatureController.points;
                  for(var elements in signature){
                    pointList_1.add([elements.offset.dx.toStringAsFixed(2),elements.offset.dy.toStringAsFixed(2)]);
                  }
                  pointList_2.add(pointList_1);
                }),
                backgroundColor: Colors.white,
                height: 500,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.green,
                    child: SizedBox(
                      height: 40,
                      child: InkWell(
                          onTap: () {
                            signature.clear();
                            pointList_1.clear();
                            pointList_2.clear();
                            signatureController.clear();
                          },
                          child: const Text("Tap To clear Screen")),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Material(
                    color: Colors.green,
                    child: SizedBox(
                      height: 40,
                      child: InkWell(
                          onTap: () {
                            print("****************************************DATA#########################");
                            print(pointList_2.length);
                          },
                          child: const Text("Tap To Show Data")),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
