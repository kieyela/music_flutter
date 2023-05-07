
import 'package:audioplayers/audio_cache.dart';
 import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MusicListen extends StatefulWidget {
  const MusicListen({super.key});

  @override
  State<MusicListen> createState() => _MusicListenState();
}

bool playing =false;
IconData playBtn = Icons.play_arrow;
   var _player = AudioPlayer();
   var cache = AudioCache();
   Duration position = new Duration();
   Duration musiclength = new Duration();

   Widget slider(){
    return Slider(
      activeColor: Colors.blue,
      inactiveColor: Colors.green,
     value: position.inSeconds.toDouble(),
     max: musiclength.inSeconds.toDouble(),
     onChanged: (value){
      seekTosec(value.toInt());
     });
   }
   void seekTosec(int sec){
    Duration newPos = Duration();
    _player.seek(newPos);
   }
   
    audio() async {
    await _player.setUrl('https://listen.radioking.com/radio/242578/stream/286663');
    _player.play();
  }

  void pause() async
  {
    _player.pause();
  }

  @override
  void initState() {
    audio();
  }


class _MusicListenState extends State<MusicListen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.green,
            ])
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 48.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:12.0),
                  child: Text("",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38.0,
                    fontWeight: FontWeight.w400
                  ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        image: AssetImage("assets/cover.jpg")
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Text(
                    "Radio",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)
                      ),
                    ),
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                          slider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 45.0,
                                  color: Colors.black,
                                  onPressed: (){

                                  }
                                , icon: Icon(Icons.skip_previous)
                                ),
                                IconButton(
                                  iconSize: 52.0,
                                  color: Colors.black,
                                  onPressed: (){
                                    
                                    if(!playing){
                                      audio();
                                      setState(() {
                                        playBtn = Icons.pause;
                                        playing =true;
                                      });
                                    }
                                    else{
                                      pause();
                                      setState(() {
                                       playBtn = Icons.play_arrow;
                                        playing =false;
                                      });
                                    }
                                  }
                                , icon: Icon(playBtn)
                                ),
                                IconButton(
                                  iconSize: 62.0,
                                  color: Colors.black,
                                  onPressed: (){

                                  }
                                , icon: Icon(Icons.skip_next)
                                ),

                              ],

                            )
                       ],

                    ),
                  ),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}