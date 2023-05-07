import 'package:flutter/material.dart';

class Music extends StatelessWidget {
  List listOfItems = List.generate(20, (index) => 'Sample Item - $index');
  Music({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: listOfItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              print('Clicked on item #$index'); 
            },
            title: Text(listOfItems[index]),
            subtitle: Text('Sample subtitle for item #$index'),
            leading: Container(
              height: 50,
              width: 50,
              color: Colors.amber,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
