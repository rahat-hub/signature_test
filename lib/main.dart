import 'dart:core';

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

    var startIndex = 0;

    List signature;
    var test = {"lines":[]};
    List<Point> test2 = [];

    var copySignature = false.obs;
    //SignatureController signatureController_1 = SignatureController();
    //signature =  signatureController_1.;
    SignatureController signatureController_1 = SignatureController();
    SignatureController signatureController_2 = SignatureController();

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
                    signature = [];
                    pointList_1 = [];

                    signature = signatureController_1.points.sublist(startIndex);
                    startIndex = signatureController_1.points.length;
                    for (Point elements in signature) {
                      pointList_1.add([elements.offset.dx.toPrecision(2), elements.offset.dy.toPrecision(2)]);
                    }
                    print(signature.length);
                    print(startIndex);
                    print(pointList_1);
                    print(pointList_1.length);
                    test["lines"]?.add(pointList_1);
                    print(test["lines"]?.length);
                    test["lines"]?.forEach((element) {print(element.length);});
                  },
                    penStrokeWidth: 2,
                    penColor: Colors.red,
                  ),
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
                              signature = [];
                              pointList_1 = [];
                              signatureController_1.clear();
                              signatureController_2.clear();
                              test["lines"] = [];
                              test2 = [];
                              startIndex = 0;
                              copySignature.value = false;
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
                              //for (var element in signatureController_1.points) {pointList_2.add(element.offset);}

                              for(var i = 0; i < test["lines"]!.length; i++ ){
                                var v = test["lines"]?[i];
                                print(v.length);
                                for(var j=0;j<v.length;j++){
                                  if (j==0 || j == v.length-1) {
                                    test2.add(Point(Offset(v[j][0], v[j][1]),PointType.tap,1.0));
                                  } else {
                                    test2.add(Point(Offset(v[j][0], v[j][1]),PointType.move,1.0));
                                  }
                                }
                              }
                              print(test2);
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
                            onTap: () async {
                              copySignature.value = true;
                              signatureController_2 = SignatureController(
                                //onDrawStart: onDrawStart(),
                                points: test2,
                                //points: signatureController_1.points,
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
              Obx(() {
                return copySignature.value != false
                    ? Material(
                        shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.blue, width: 2)),
                        child: Signature(
                          controller: signatureController_2,
                          backgroundColor: Colors.white,
                          height: 300,
                          width: double.infinity,
                        ),
                      )
                    : const SizedBox();
              })
            ],
          ),
        ),
      ),
    );
  }

  collectedPoint({listPoint}) {
    List<Point>? damy_1 = [];
    List<Point>? damy_2 = [];

    for (int i = 0; i < listPoint.length; i++) {
      // for (int j = 0; j < listPoint[i].length; j++) {
      //   //print(listPoint[i][j][0]);
      //   //print(listPoint[i][j][1]);
      //   damy_1.add(Point(Offset(double.parse(listPoint[i][j][0]), double.parse(listPoint[i][j][1])), PointType.move, 0.0));
      // }

      //damy_1.add(Point(Offset(double.parse(listPoint[i][0]), double.parse(listPoint[i][1])), PointType.move, 0.0));
      damy_1.add(Point(Offset(listPoint[i][0], listPoint[i][1]), PointType.move, 0.0));

      //damy_2.add(damy_1 as Point);
    }
    return damy_1;

  }
}
