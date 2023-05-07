import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import 'model.dart';

class AllMusic extends StatefulWidget {
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
  State<AllMusic> createState() => _AllMusicState();

}

class _AllMusicState extends State<AllMusic> {
  late Future<List<Album>> futureMusic;

  String currentTitle ="";
  String currentsubTitle ="";
  String currentImage ="";
  String mus = "";
  IconData btnIcon = Icons.play_arrow;

   var _player = AudioPlayer();

  
  bool isPlaying = false;
  String currenSong ="";


  audio() async {
  await _player.setUrl(mus);
    _player.play();
  }
  void pause() async
  {
    await _player.setUrl(mus);
    _player.pause();
  }

  @override
  void initState() {
   futureMusic = AllMusic.fetchMusic();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My PlayList", style: TextStyle(color:Colors.black)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Album>>(
          future: futureMusic,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        setState(() {
                          currentTitle = snapshot.data![index].title;
                          currentsubTitle = snapshot.data![index].subtitle;
                          currentImage = snapshot.data![index].image;
                          mus = snapshot.data![index].audio;
                        });
                        // load in AudioPlayer
                        
                      },
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].subtitle),
                      leading: Container(
                        height: 50,
                        width: 50,
                        child: Image.network(snapshot.data![index].image),
                      ),
                      trailing: Visibility(
                        visible: snapshot.data![index].audiodownloadAllowed,
                        child: IconButton(
                          icon: const Icon(
                            Icons.download,
                            size: 24.0,
                          ),
                          onPressed: () {
                            html.window.open(snapshot.data![index].downloadLink, '');
                          },
                        ),
                      )
                      );
                },
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color(0x55212121),
                blurRadius: 8.0
              ),

            ]),
            child: Column(
              children: [
                Slider.adaptive(value: 0.0 , onChanged: ((value) {})),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 12.0,right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                            image: NetworkImage(currentImage)
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [ 
                            Text(
                              currentTitle,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                             Text(
                              currentsubTitle,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                         icon: Icon(btnIcon), 
                         iconSize: 42.0,
                         onPressed: () { 
                          if(!isPlaying){
                            audio();
                            setState(() {
                              btnIcon = Icons.pause;
                              isPlaying = true;
                            });
                          }
                          else{
                            pause();
                            setState(() {
                              btnIcon =Icons.play_arrow;
                              isPlaying = false;
                            });
                          }
                          },
                       )
                    ],
                  ),
                )
              ],
  
            ) ,
          )
        ]

        ) ,
    );
  }
}
