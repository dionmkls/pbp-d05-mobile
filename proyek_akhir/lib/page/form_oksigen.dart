import 'package:proyek_akhir/page/forum.dart';

import '../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'form_oksigen.dart';
import 'apd_form.dart';
import 'apd_page.dart';
import 'package:proyek_akhir/page/home_page.dart';
import 'vaksin_form.dart';
import 'vaksin_index.dart';
import 'oksigen.dart';
import 'rs_form.dart';
import 'rs_page.dart';
import 'faq.dart';
import '../model/oksigen_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenWidth(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

double screenHeight(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenHeightExcludingToolbar(BuildContext context,
    {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}

Future<Album> createAlbum(String url, String address, String phone) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'url': url,
      'address': address,
      'phone': phone,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

void main() {
    runApp(FormOksigen());
}

class FormOksigen extends StatelessWidget{
    const FormOksigen({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
        return MaterialApp(home: MyStatefulWidget());
    }
}

class MyStatefulWidget extends StatefulWidget {
    MyStatefulWidget({Key? key}) : super(key: key);
    @override
    MyState createState() => MyState();
}


class MyState extends State<MyStatefulWidget>{
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    int light = 1;
    Brightness _brightness = Brightness.light;
    static const warnagradien = LinearGradient(colors: <Color>[Color(0xff71b7e6), Color(0xff9b59b6)]);
    final TextEditingController urlcontroller = TextEditingController();
    final TextEditingController addresscontroller = TextEditingController();
    final TextEditingController phonecontroller = TextEditingController();
    final TextEditingController domisilicontroller = TextEditingController();
    Future<Album>? _futureAlbum;

    void _onItemTapped() {
        setState(() {
            light ^= 1;
            if (light == 0){
                _brightness = Brightness.dark;
            }
            else{
                _brightness = Brightness.light;
            }
        });
    }

    void _showDialog() {
    // flutter defined function
        showDialog(
            context: context,
            builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                    title: new Text("Peringatan!"),
                    content: new Text("Penyuntingan data hanya boleh dilakukan oleh administrator"),
                    actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                        new TextButton(
                            child: new Text("Close"),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                );
            },
        );
    }
    

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData(
                brightness: _brightness,
                primaryColor: Colors.lightBlue[800],
            ),
            home: Scaffold(
                appBar: AppBar(
                    title: Text('''PBP D-05'''),
                    actions: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.dark_mode),
                            tooltip: 'dark mode',
                            onPressed: _onItemTapped,
                        ),
                    ],
                ),
                drawer: Drawer(
                    child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                            DrawerHeader(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                ),
                                child: Text(
                                    'Navigation Menu',
                                    style: TextStyle(
                                    color: Colors.white,
                                        fontSize: 24,
                                    ),
                                ),
                            ),
                            ListTile(
                                leading: Icon(Icons.home),
                                title: Text('Beranda'),
                                onTap: () {
                                // TODO
                                },
                            ),
                            ListTile(
                                leading: FaIcon(FontAwesomeIcons.syringe),
                                title: Text('Vaksin'),
                                onTap: () {
                                // TODO
                                },
                            ),
                            ExpansionTile(
                                title: Text("Oksigen"),
                                leading: FaIcon(FontAwesomeIcons.medkit),
                                children: <Widget>[
                                    ListTile(
                                        leading: FaIcon(FontAwesomeIcons.medkit),
                                        title: Text('Lokasi'),
                                        onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => Oksigen()),
                                            );
                                        },
                                    ),
                                    ListTile(
                                        leading: FaIcon(FontAwesomeIcons.medkit),
                                        title: Text('Form'),
                                        onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => FormOksigen()),
                                            );
                                        },
                                    ),
                                ],
                            ),
                            ListTile(
                                leading: FaIcon(FontAwesomeIcons.tshirt),
                                title: Text('APD'),
                                onTap: () {
                                // TODO
                                },
                            ),
                            ListTile(
                                leading: FaIcon(FontAwesomeIcons.hospital),
                                title: Text('Rumah Sakit'),
                                onTap: () {
                                // TODO
                                },
                            ),
                            ListTile(
                                leading: Icon(Icons.forum),
                                title: Text('Forum'),
                                onTap: () {
                                // TODO
                                },
                            ),
                            ListTile(
                                leading: FaIcon(FontAwesomeIcons.questionCircle),
                                title: Text('FAQ'),
                                onTap: () {
                                // TODO
                                },
                            ),
                        ],
                    ),
                ),
        body: Column(
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                      child: Center(
                    child: Form(
                      key: _formKey,
                      child: Builder(
                        builder: (context) => Column(
                          children: <Widget>[
                            // ISI DENGAN CONTENT
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter an url',
                                labelText: 'url',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'cannot enter empty data';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter an address',
                                labelText: 'address',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'cannot enter empty data';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter a phone number',
                                labelText: 'phone',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'cannot enter empty data';
                                }
                                return null;
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')),
                                  );
                                }
                              },
                              child: Text("Submit",
                                  style: TextStyle(fontSize: 20)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                onPrimary: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ],),
        floatingActionButton: new FloatingActionButton(
            elevation: 10.0,
            child: new Icon(Icons.chat),
            backgroundColor: Color(0xFF162A49),
            onPressed: () {
              // TODO
            }),
      ),
    );
  }
}
