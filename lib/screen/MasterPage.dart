import 'dart:async';
import 'package:exhibition/model/Shope.dart';
import 'package:flutter/material.dart';
import 'package:exhibition/public/SizeConfig.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:exhibition/model/BaseListDaynamicStandard.dart';
import 'package:exhibition/Public/NetworkAPI.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class MasterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MasterPage();
  }
}

class _MasterPage extends State<MasterPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _search = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    super.initState();
  }

  //for map
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(36.325640, 59.406540);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

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
                body:  ListView(children: <Widget>[Column(
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
                              print("asdasd");
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
                      width:  _value!=3?SizeConfig.blockSizeHorizontal * 100:0,
                      height: _value!=3?SizeConfig.blockSizeVertical * 9:0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              width: SizeConfig.blockSizeHorizontal * 90,
                              height: SizeConfig.blockSizeVertical * 8,
                              child: _value!=3?TextField(
                                onChanged: (value){
                                  setState(() {

                                  });
                                },
                                controller: _search,
                                textAlign: TextAlign.right,
                                decoration: new InputDecoration(
                                    filled: true,
                                    suffixIcon: Icon(Icons.search),
                                    border: new OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(30.0),
                                      ),
                                    ),
                                    hintStyle:
                                    new TextStyle(color: Colors.grey[800]),

                                    fillColor: Colors.white70),
                              ):Container())
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
                      height: _value==3?SizeConfig.blockSizeVertical * 82:SizeConfig.blockSizeVertical * 73,
                      child: stateMaster(),
                    )
                  ],
                )],),
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
    if (_value == 1 || _value==2 ) {
      return FutureBuilder<List<Shope>>(
          future: getAllshope(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              // return: show loading widget
              return Container(
                  width: 80,
                  height: 80,
                  child:Center(child:CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              // return: show error widget
            }
            List<Shope> users =new List<Shope>(); /*snapshot.data ?? [];*/
            if(snapshot.data.length>0)
             {
               for(int i=0;i<snapshot.data.length;i++)
               {
                 if(_search.text.length<1? snapshot.data[i].field2==_value.toString():
                          (snapshot.data[i].field2==_value.toString()&&
                              (snapshot.data[i].description.contains(_search.text) ||
                                  snapshot.data[i].field1.contains(_search.text)||
                                  snapshot.data[i].title.contains(_search.text))))
                   {
                     users.add(snapshot.data[i]);
                   }
               }}


            return GridView.count(
              primary: true,
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              children: List.generate(users.length, (index) {
                return card(users[index]);
              }),
            );

          });
    }  else //for value 3
    {
      return GoogleMap(
        mapType: MapType.hybrid,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 16.0,
        ),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
        ].toSet(),/* gestureRecognizers: Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))*/
      );
    }
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
                    new Text(shope.field1,style:
                    TextStyle(fontSize: 15)),
                    new Text("غرفه : "+shope.title, style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          )),
      onTap: () {},
    );
    /*Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child:Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(shope.title,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight:FontWeight.bold),),
                      Text(shope.description,style: TextStyle(fontSize: 16,color: Colors.black87),)
                    ],
                  )),
              Image.network("http://harekat.kiancode.ir/assets/uploads/rahman/"+shope.file1),

            ],
          ),
        ));*/
  }

/*  Future getProjectDetails() async {
    List<Shope> projetcList = await someFutureCall();
    return projetcList;
  }*/

  Future<List<Shope>> _fetchJobs() async {
    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Shope.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

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

  Future<List<Shope>> Register() async {
    String user = "";
    //  final postData = {'user': EmainPhone.text,'password': Password.text,'nickname':FullName.text ,'device':'123',"log":"123"};
    //final header = {'header1key' : 'header1val'};
    final postData = {};
    await NetworkAPI().httpPostRequest('rahmanlist/', postData, null,
        (status, response) {
      if (status == true) {
        switch (response.s) {
          case 1:
            var tmpD = response.d;
            List<Shope> getShope = tmpD.map<Shope>((json) {
              return Shope.fromJson(json);
            }).toList();
            print(getShope.toList());
            return getShope;
            /*users.insert(Users.fromJson(response.d),"0");
            user=Users.fromJson(response.d).username;*/
            return true;

            break;
          case 1000:
            break;
          case 1012:
            break;
          case 1100:
            break;
          case 1003:
            break;

          case 1011:
            break;

          case 1031:
            break;

          case 1001:
            break;
          case 1017:
            break;
        }

        /* for (var mainRequest in response) {
          MainRequest u =  MainRequest.fromMap(mainRequest);
         */ /* Users.insert(u);*/ /**/ /* //insert to SQLite table*/ /*
        }*/
      } else {
        return "";
      }
    });
    return null;
  }
}
