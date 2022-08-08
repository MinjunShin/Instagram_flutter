import 'package:flutter/material.dart';
import './style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  List dataFromServer = [];
  var scroll = ScrollController();
  var userImage;

  getData(String uri) async {
    final result = await http.get(Uri.parse(uri));

    setState(() {
      dataFromServer = jsonDecode(result.body);
    });
  }

  addData(String uri) async {
    final result = await http.get(Uri.parse(uri));
    final convertedResult = jsonDecode(result.body);
    setState(() {
      dataFromServer.add(convertedResult);
    });
  }

  @override
  void initState() {
    getData('https://codingapple1.github.io/app/data.json');
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
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
                          )));
            },
          )
        ],
      ),
      body: ListView.builder(
          controller: scroll,
          itemCount: dataFromServer.length,
          itemBuilder: (context, i) {
            return DefaultPost(data: dataFromServer, index: i);
          }),
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

class DefaultPost extends StatelessWidget {
  final List data;
  final index;
  const DefaultPost({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return Column(
        children: [
          Image.network(data[index]['image']),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('좋아요 ${data[index]['likes']}',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    Text('${data[index]['user']}',
                        style: TextStyle(color: Colors.grey)),
                    Text('${data[index]['content']}',
                        style: TextStyle(color: Colors.grey)),
                  ]),
            ),
          ),
        ],
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key, this.userImage}) : super(key: key);
  final userImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          userImage == null ? SizedBox.shrink() : Image.file(userImage),
          Text('이미지 업로드 화면'),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.close)),
        ]));
  }
}
