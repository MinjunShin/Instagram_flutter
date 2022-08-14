import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './widgets/defaultPost.dart';
import './widgets/uploadPage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    theme: theme,
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/detail': (context) => UploadPage(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var _isloaded = false;
  var _isloading = false;
  List dataFromServer = [];
  var scroll = ScrollController();
  var userImage;

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    // key-value 형태로 데이터를 저장
    storage.setString('name', '데이터');
    storage.setBool('bool', true);
    storage.setInt('int', 2);
    storage.setStringList('list', ['1', '2', '3']);
    var map = {'age' : 20};
    storage.setString('map', jsonEncode(map));
    var savedMap = storage.getString('map');
    var result = storage.get('name');
    var result2 = storage.get('list');
    var result3 = storage.getString('map');
    print(jsonDecode(result3!));
    print(result2);
  }

  getData(String uri) async {
    final result = await http.get(Uri.parse(uri));
    setState(() {
      dataFromServer = jsonDecode(result.body);
    });
  }

  addData(String uri) async {
    setState(() {
      _isloading = true;
    });
    _isloading = true;
    final result = await http.get(Uri.parse(uri));
    final convertedResult = jsonDecode(result.body);
    setState(() {
      dataFromServer.add(convertedResult);
      _isloaded = true;
      _isloading = false;
    });
  }

  uploadData(data) {
    setState(() {
        dataFromServer.add(data);
        print(dataFromServer);
      }
    );
  }

  @override
  void initState() {
    getData('https://codingapple1.github.io/app/data.json');
    super.initState();
    saveData();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent && _isloaded == false) {
        addData('https://codingapple1.github.io/app/more1.json');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () async {
              final picker = ImagePicker();
              final image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  userImage = File(image.path);
                });
              }
              if (!mounted) return;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => UploadPage(
                            userImage: userImage,
                            uploadData: uploadData,
                          )));
            },
          )
        ],
      ),
      body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: scroll,
                  itemCount: dataFromServer.length,
                  itemBuilder: (context, i) {
                    return DefaultPost(data: dataFromServer, index: i);
                  }),
            ),
            _isloading ? CircularProgressIndicator() : SizedBox.shrink(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // onTap : (i){
        //   setState(() {
        //     tab = i;
        //   });
        // },
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Shop',
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag))
        ],
      ),
    );
  }
}

