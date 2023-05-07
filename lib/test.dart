import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sb_dart_project/model.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Album> lisbum = [];
  static Future<List<Album>> fetchMusic() async {
    var response = await http.get(
        Uri.parse('https://api.jamendo.com/v3.0/tracks/?client_id=f8a2ed1b'));
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body)['results'];
      return (map as List).map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception('Erreur album');
    }
  }
  void initState(){
    fetchMusic();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
      backgroundColor: Colors.blue,
      elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recherche music",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none
                ),
                hintText: "eg: Recherche",
                prefixIcon:Icon(Icons.search),
                prefixIconColor: Colors.black
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView(
                
              ),
            )
            
          ],
        ),
      ),

    );
  }
}

