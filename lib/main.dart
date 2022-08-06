import 'package:flutter/material.dart';
import './style.dart';

void main() {
  runApp(
      MaterialApp(
        theme: theme,
        home: MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var tab = 0;


  @override
  Widget build(BuildContext context) {
    final pageController = PageController(
      initialPage: 1,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: (){},
          )
        ],
      ),
      body:
      PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: <Widget> [
          Container(
              color: Colors.red,
              child: Text('홈페이지')
          ),
          Container(
              color: Colors.blue,
              child: Text('샵페이지')
          )
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap : (i){
          setState(() {
            tab = i;
          });
          print(i);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            label: 'Shop',
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag)
          )
        ],
      ),
    );
  }
}

