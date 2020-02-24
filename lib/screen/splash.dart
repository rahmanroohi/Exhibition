import 'dart:async';
import 'package:exhibition/screen/MasterPage.dart';
import 'package:flutter/material.dart';
import 'package:exhibition/public/SizeConfig.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Splash();
  }
}

class _Splash extends State<Splash> {
  bool Visible = true;

  @override
  void initState() {
    super.initState();
    //for locked portrait screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    loadData();
  }

  /***
   * 0 login
   * 1 veryfication code
   */

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MasterPage()));
  }

  //commit change users
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Scaffold(
          body: Container(
              color: Color.fromRGBO(235, 235, 235, 5),
              child: Stack(
                children: <Widget>[
                  Center(
                      child: Container(
                          padding:
                              EdgeInsets.all(SizeConfig.blockSizeVertical * 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset("images/imgeynak.png"),
                              Divider(
                                height: 60,
                                color: Colors.transparent,
                              ),
                              Image.asset("images/imagetitle.png"),
                              Divider(
                                height: 10,
                                color: Colors.transparent,
                              ),
                              Image.asset("images/imagedate.png")
                            ],
                          )))

                ],
              )),
        ));
  }

  @override
  dispose() {
    //for locked portrait screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
