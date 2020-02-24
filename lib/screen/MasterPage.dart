import 'dart:async';
import 'package:exhibition/model/Shope.dart';
import 'package:flutter/material.dart';
import 'package:exhibition/public/SizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:exhibition/model/BaseListDaynamicStandard.dart';
import 'package:exhibition/Public/NetworkAPI.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:location/location.dart';

class MasterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MasterPage();
  }
}

class _MasterPage extends State<MasterPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _value = 1;

  //for select all Textfeild when get focus
  final _controllerSearch = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    getCurrentLoaction();

    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controllerSearch.selection = TextSelection(
            baseOffset: 0, extentOffset: _controllerSearch.text.length);
      }
    });
  }

  void getCurrentLoaction() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      posation = res;
      _chaild = mapWidget();
    });
  }

  Widget mapWidget() {
    return GoogleMap(

      myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(36.325640, 59.406540), zoom: 12),
        onMapCreated: (GoogleMapController contorolMap) {
          _controller = contorolMap;
        },markers: _createMarker(),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet());
  }

  //for map
  /*Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(36.325640, 59.406540);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }*/
  GoogleMapController _controller;
  Position posation;
  Widget _chaild;

  //commit change users
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SafeArea(
            child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Color.fromRGBO(235, 235, 235, 1),
                body: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: SizeConfig.blockSizeVertical * 5,
                          margin: EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey,
                                size: 30.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                              Text(
                                "MopeX",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _scaffoldKey.currentState.openEndDrawer();
                                },
                                child: Icon(
                                  Icons.drag_handle,
                                  color: Colors.grey,
                                  size: 30.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: _value != 3
                              ? SizeConfig.blockSizeHorizontal * 100
                              : 0,
                          height: _value != 3
                              ? SizeConfig.blockSizeVertical * 9
                              : 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.blockSizeHorizontal * 90,
                                  height: SizeConfig.blockSizeVertical * 8,
                                  child: _value != 3
                                      ? TextField(
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          controller: _controllerSearch,
                                          focusNode: _focusNode,
                                          textAlign: TextAlign.right,
                                          decoration: new InputDecoration(
                                              filled: true,
                                              suffixIcon: Icon(Icons.search),
                                              border: new OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(30.0),
                                                ),
                                              ),
                                              hintStyle: new TextStyle(
                                                  color: Colors.grey[800]),
                                              fillColor: Colors.white70),
                                        )
                                      : Container())
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.blockSizeVertical * 2),
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 5,
                                right: SizeConfig.blockSizeHorizontal * 5),
                            width: SizeConfig.blockSizeHorizontal * 100,
                            height: SizeConfig.blockSizeVertical * 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 27,
                                    color: Colors.transparent,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: _value == 1
                                                ? Color.fromRGBO(41, 88, 122, 1)
                                                : Colors.white70,
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: new Center(
                                          child: new Text(
                                            'A سالن ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: _value == 1
                                                    ? Colors.white
                                                    : Colors.black54),
                                          ),
                                        )),
                                  ),
                                  onTap: () {
                                    _value = 1;
                                    setState(() {});
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 27,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: _value == 2
                                                ? Color.fromRGBO(41, 88, 122, 1)
                                                : Colors.white70,
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: new Center(
                                          child: new Text('  B سالن',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: _value == 2
                                                      ? Colors.white
                                                      : Colors.black54)),
                                        )),
                                  ),
                                  onTap: () {
                                    _value = 2;
                                    setState(() {});
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 25,
                                    color: Colors.transparent,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: _value == 3
                                                ? Color.fromRGBO(41, 88, 122, 1)
                                                : Colors.white70,
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(40.0))),
                                        child: new Center(
                                          child: new Text('موقعیت',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: _value == 3
                                                      ? Colors.white
                                                      : Colors.black54)),
                                        )),
                                  ),
                                  onTap: () {
                                    _value = 3;
                                    setState(() {});
                                  },
                                )
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2,
                              bottom: SizeConfig.blockSizeVertical * 2),
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: _value == 3
                              ? SizeConfig.blockSizeVertical * 82
                              : SizeConfig.blockSizeVertical * 73,
                          child: stateMaster(),
                        )
                      ],
                    )
                  ],
                ),
                endDrawer: Drawer(
                  // Add a ListView to the drawer. This ensures the user can scroll
                  // through the options in the drawer if there isn't enough vertical
                  // space to fit everything.
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        child: Text('Drawer Header'),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      ListTile(
                        title: Text('Item 1'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      ListTile(
                        title: Text('Item 2'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                    ],
                  ),
                ))));
  }

  Widget stateMaster() {
    if (_value == 1 || _value == 2) {
      return FutureBuilder<List<Shope>>(
          future: getAllshope(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              // return: show loading widget
              return Container(
                  width: 80,
                  height: 80,
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text(
                    'مشکل در ارتباط با اینترنت',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            List<Shope> users = new List<Shope>(); /*snapshot.data ?? [];*/
            if (snapshot.data.length > 0) {
              for (int i = 0; i < snapshot.data.length; i++) {
                if (_controllerSearch.text.length < 1
                    ? snapshot.data[i].field2 == _value.toString()
                    : (snapshot.data[i].field2 == _value.toString() &&
                        (snapshot.data[i].description
                                .contains(_controllerSearch.text) ||
                            snapshot.data[i].field1
                                .contains(_controllerSearch.text) ||
                            snapshot.data[i].title
                                .contains(_controllerSearch.text)))) {
                  users.add(snapshot.data[i]);
                }
              }
            }

            return GridView.count(
              primary: true,
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              children: List.generate(users.length, (index) {
                return card(users[index]);
              }),
            );
          });
    } else //for value 3
    {
      return _chaild;
      /*GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 16.0,
        ),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
        ].toSet(),*/ /* gestureRecognizers: Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))*/ /*
      );*/
    }
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("home"),
          position: LatLng(36.325640, 59.406540),
          icon: BitmapDescriptor.defaultMarker,
       infoWindow: InfoWindow(title: "نمایشگاه"))
    ].toSet();
  }

  Widget card(Shope shope) {
    return GestureDetector(
      child: Card(
          elevation: 1.5,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              new Image.network(
                "http://harekat.kiancode.ir/assets/uploads/rahman/" +
                    shope.file1,
                width: SizeConfig.blockSizeHorizontal * 30,
                height: SizeConfig.blockSizeVertical * 15,
              ),
              new Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Divider(),
                    new Text(
                      shope.description,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    new Text(shope.field1, style: TextStyle(fontSize: 15)),
                    new Text("غرفه : " + shope.title,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          )),
      onTap: () {},
    );
  }

/*  final Map<String, Marker> _markers = {};
  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }*/

  //for get all brand
  Future<List<Shope>> getAllshope() async {
    String methodName = "";

    Map<String, dynamic> body;
    /* sharedPreferences = await SharedPreferences.getInstance();*/

/*    body = {
      */ /*'user': sharedPreferences.get("user"),
      'password': sharedPreferences.get("password"),
      'device': sharedPreferences.get("device"),*/ /*
    };*/
    body = {};
    methodName = "rahmanlist/";
    return http
        .post("http://harekat.kiancode.ir/api/" + methodName, body: body)
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      BaseListDaynamicStandard BaseListDaynamic =
          BaseListDaynamicStandard.fromJson(json.decode(response.body));

      var tmpD = BaseListDaynamic.d;
      List<Shope> getAllBrands = tmpD.map<Shope>((json) {
        return Shope.fromJson(json);
      }).toList();

      return getAllBrands;
    });
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
