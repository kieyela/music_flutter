import 'package:flutter/material.dart';
import 'package:sb_dart_project/all-music.dart';
import 'package:sb_dart_project/search.dart';
import 'package:sb_dart_project/stream.dart';
import 'music.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EKS',
      theme: ThemeData(
       primarySwatch: Colors.blue,
       secondaryHeaderColor: Colors.black,
       tabBarTheme: const TabBarTheme(
        labelColor: Colors.blue, unselectedLabelColor: Colors.black
       )
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: const BottomAppBar(
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.all_inbox)),
                Tab(icon: Icon(Icons.music_note_outlined)),
                Tab(icon: Icon(Icons.search)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AllMusic(),
              MusicListen(),
              Search()
            ]
            )
          )
        ),
    );
  }
}
