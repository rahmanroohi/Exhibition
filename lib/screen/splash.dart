import 'dart:async';
import 'package:exhibition/screen/MasterPage.dart';
import 'package:flutter/material.dart';
import 'package:exhibition/public/SizeConfig.dart';
class Splash extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Splash();
  }
}

class _Splash extends State<Splash>  {

  bool Visible =true;
  @override
  void initState() {
    super.initState();
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
        (context) =>MasterPage()));
  }

  //commit change users
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: Container(
              color:Color.fromRGBO(235, 235, 235, 5),
              child:Stack(
                children: <Widget>[
                 AnimatedOpacity(
                   opacity:Visible?1:0,
                     duration:Duration(seconds:3 ) ,
                     child:Center(child:Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                   Image.asset("images/imgeynak.png"),
                   Divider(height: 60,color: Colors.transparent,),
                   Image.asset("images/imagetitle.png"),
                     Divider(height: 10,color: Colors.transparent,),
                   Image.asset("images/imagedate.png")
                 ],)))
                  /*Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 100,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(245, 89, 31, 100),
                        Color.fromRGBO(240, 109, 31, 10),
                        Color.fromRGBO(250, 151, 64, 1)
                      ])),
            ),
            Center(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 30,
                  height: SizeConfig.blockSizeVertical * 30,
                  child: Image.asset("assets/images/logo.png"),
                ))*/
                ],
              )),
        ));
  }

}
