import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'all-music.dart';
import 'model.dart';
import 'dart:html' as html;


class Search extends StatefulWidget {
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

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<List<Album>> futureMusic;

  String currentTitle ="";
  String currentsubTitle ="";
  String currentImage ="";
  String mus = "";
  IconData btnIcon = Icons.play_arrow;

  var _player = AudioPlayer();

  bool isPlaying = false;
  String currenSong ="";

  TextEditingController searchController = TextEditingController();
  List<Album> filteredMusic = [];

  audio() async {
    await _player.setUrl(mus);
    _player.play;
  }
  void pause() async
  {
    await _player.setUrl(mus);
    _player.pause();
  }

  @override
  void initState() {
    futureMusic = AllMusic.fetchMusic();
    super.initState();
  }

  void filterMusic(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredMusic = filteredMusic.where((album) =>
            album.title.toLowerCase().contains(query.toLowerCase()) ||
            album.subtitle.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredMusic = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: searchController,
          onChanged: (value) {
            filterMusic(value);
          },
          decoration: InputDecoration(
            hintText: "Rechercher",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Album>>(
              future: futureMusic,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Album> music = filteredMusic.isNotEmpty ? filteredMusic : snapshot.data!;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            currentTitle = music[index].title;
                            currentsubTitle = music[index].subtitle;
                            currentImage = music[index].image;
                            mus = music[index].audio;
                          });
                        },
                        title: Text(music[index].title),
                        subtitle: Text(music[index].subtitle),
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: Image.network(music[index].image),
                        ),
                        trailing: Visibility(
                          visible: music[index].audiodownloadAllowed,
                          child: IconButton(
                            icon: const Icon(
                              Icons.download,
                              size: 24.0,
                            ),
                            onPressed: () {
                              html.window.open(music[index].downloadLink, '');
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: music.length,
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
