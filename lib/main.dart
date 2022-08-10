import 'package:flutter/cupertino.dart';
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
                            uploadData: uploadData,
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
          data[index]['image'].runtimeType == String ?
          Image.network(data[index]['image'], width: 500, height: 200) :
          Image.file(data[index]['image'], width: 500, height: 200),
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
  UploadPage({Key? key, this.userImage, this.uploadData}) : super(key: key);
  final userImage;
  final uploadData;
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          userImage == null ? SizedBox.shrink() : Image.file(userImage, width: 500, height: 200),
          Text('이미지 업로드 화면'),
          TextField(
            controller: textFieldController,
            maxLines: 1,
          ),
          TextButton(onPressed: (){
            const likes = 0;
            const user = 'Minjun Shin';
            final content = textFieldController.text;
            uploadData({
              'id': 4,
              'image': userImage,
              'likes': likes,
              'date' : 'Aug 10',
              'content' : content,
              'user' : user
            });
            Navigator.pushNamed(context, '/');
          }, child: Text('Upload')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.close)),
        ]));
  }
}
