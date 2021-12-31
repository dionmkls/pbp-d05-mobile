import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../model/rumah_sakit.dart';

class FormRS extends StatefulWidget {
  @override
  _FormRSState createState() => _FormRSState();
}

class _FormRSState extends State<FormRS> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String nama = '';
  String lokasi = 'JA';
  String alamat = '';
  String urlGmaps = '';
  String noTelp = '';
  String tersedia = 'IK';

  Future<void> berhasilAddRS() async {
    const url = 'https://tk-pbp-d05.herokuapp.com/rumah-sakit/add';
    try {
      final response = await http.post(Uri.parse(url),

        body: jsonEncode({
          'nama': nama,
          'lokasi': lokasi,
          'alamat': alamat,
          'url_gmaps': urlGmaps,
          'no_telp': noTelp,
          'tersedia': tersedia,
        })
      );
      Map<String, dynamic> extractedData = jsonDecode(response.body);
      extractedData.forEach((key, value) {print(value);});
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(extractedData['nama'] +
            ' berhasil ditambah.')),
      );
    print('berhasil ditambah');
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Rumah Sakit"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "RS Indonesia",
                      labelText: "Nama",
                      icon: Icon(Icons.local_hospital_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama rumah sakit tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        nama = newValue!;
                      });
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: new InputDecoration(
                      hintText: "Jabodetabek atau Luar",
                      labelText: "Lokasi",
                      icon: Icon(Icons.location_city_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    onChanged:(String? newValue) {
                      setState(() {
                        lokasi = newValue!;
                      });
                    },
                    value: lokasi,
                    items: dropdownItemsLokasi,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "Jln. ...",
                      labelText: "Alamat",
                      icon: Icon(Icons.map_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Alamat rumah sakit tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        alamat = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "https:// ...",
                      labelText: "Url Gmaps",
                      icon: Icon(Icons.location_on_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Url rumah sakit tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        urlGmaps = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "021-xxxxxxx",
                      labelText: "No Telp",
                      icon: Icon(Icons.call_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No. Telp rumah sakit tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        noTelp = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: new InputDecoration(
                      labelText: "Tersedia",
                      hintText: "ICU (I) atau Kamar (K)",
                      icon: Icon(Icons.medical_services_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        tersedia = newValue!;
                      });
                    },
                    value: tersedia,
                    items: dropdownItemsTersedia,
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Menambahkan Data')),
                      );
                      berhasilAddRS();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormRSEdit extends StatefulWidget {
  int id;

  FormRSEdit(this.id);

  @override
  _FormRSEditState createState() => _FormRSEditState();
}

class _FormRSEditState extends State<FormRSEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int id = -1;
  String nama = '';
  String lokasi = 'JA';
  String alamat = '';
  String urlGmaps = '';
  String noTelp = '';
  String tersedia = 'IK';

  Future<void> fetchEditData() async {
    int id = widget.id;
    String url =
      'https://tk-pbp-d05.herokuapp.com/rumah-sakit/flutter-rs/?from=flutter&to=edit&id=${id.toString()}';
    try {
      final response = await http.get(Uri.parse(url));
      Map<String, dynamic> data = jsonDecode(response.body);

      setState(() {
        id = id;
        nama = data['nama'];
        lokasi = data['lokasi'];
        alamat = data['alamat'];
        urlGmaps = data['url_gmaps'];
        noTelp = data['no_telp'];
        tersedia = data['tersedia'];
      });
      print('Berhasil fetch data untuk diedit');
    } catch (e) {
      print(e);
    }
  }

  Future<void> berhasilEditRS() async {
    String url = 'https://tk-pbp-d05.herokuapp.com/rumah-sakit/${id.toString()}/edit';
    try {
      final response = await http.post(Uri.parse(url),

        body: jsonEncode({
          'nama': nama,
          'lokasi': lokasi,
          'alamat': alamat,
          'url_gmaps': urlGmaps,
          'no_telp': noTelp,
          'tersedia': tersedia,
        })
      );
      Map<String, dynamic> extractedData = jsonDecode(response.body);
      extractedData.forEach((key, value) {print(value);});
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(extractedData['nama'] +
          ' berhasil diedit.')),
      );
      print('berhasil edit');
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    // fetch data
    fetchEditData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Rumah Sakit"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "RS Indonesia",
                      labelText: "Nama",
                      icon: Icon(Icons.local_hospital_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama rumah sakit tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        nama = newValue!;
                      });
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: new InputDecoration(
                      hintText: "Jabodetabek atau Luar",
                      labelText: "Lokasi",
                      icon: Icon(Icons.location_city_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    onChanged:(String? newValue) {
                      setState(() {
                        lokasi = newValue!;
                      });
                    },
                    value: lokasi,
                    items: dropdownItemsLokasi,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "Jln. ...",
                      labelText: "Alamat",
                      icon: Icon(Icons.map_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Alamat rumah sakit tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        alamat = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "https:// ...",
                      labelText: "Url Gmaps",
                      icon: Icon(Icons.location_on_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Url rumah sakit tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        urlGmaps = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "021-xxxxxxx",
                      labelText: "No Telp",
                      icon: Icon(Icons.call_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No. Telp rumah sakit tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        noTelp = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: new InputDecoration(
                      labelText: "Tersedia",
                      hintText: "ICU (I) atau Kamar (K)",
                      icon: Icon(Icons.medical_services_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        tersedia = newValue!;
                      });
                    },
                    value: tersedia,
                    items: dropdownItemsTersedia,
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Menambahkan Data')),
                      );
                      berhasilEditRS();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}