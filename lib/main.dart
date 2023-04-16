import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    //SignatureController signatureController_1 = SignatureController();
    //signature =  signatureController_1.;
    SignatureController signatureController_1 = SignatureController().obs as SignatureController;
    SignatureController signatureController_2 = SignatureController().obs as SignatureController;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Signature Test"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.blue, width: 2)),
                child: Signature(
                  controller: signatureController_1 = SignatureController(onDrawEnd: () {
                    signature = signatureController_1.points;
                    for (var elements in signature) {
                      pointList_1.add([elements.offset.dx.toStringAsFixed(2), elements.offset.dy.toStringAsFixed(2)]);
                    }
                    pointList_2.add(pointList_1);
                  }),
                  backgroundColor: Colors.white,
                  height: 300,
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
                              signatureController_1.clear();
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
                              print(pointList_2);
                            },
                            child: const Text("Tap To Show Data")),
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
                              signatureController_2 = SignatureController(
                                points: collectedPoint(listPoint: pointList_2),
                                penStrokeWidth: 2,
                                penColor: Colors.red,
                                exportBackgroundColor: Colors.blue,
                              );
                            },
                            child: const Text("Tap To Copy Signature")),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                  shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.blue, width: 2)),
                  child: Signature(
                    controller: signatureController_2,
                    backgroundColor: Colors.white,
                    height: 300,
                    width: double.infinity,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  collectedPoint({listPoint}) {
    List<Point>? damy = [];

    for (int i = 0; i < listPoint.length; i++) {
      for (int j = 0; j < listPoint[i].length; j++) {
        //print(listPoint[i][j][0]);
        //print(listPoint[i][j][1]);
        damy.add(Point(Offset(double.parse(listPoint[i][j][0]), double.parse(listPoint[i][j][1])), PointType.move, 0.0));
      }
    }
    return damy;
  }

}
