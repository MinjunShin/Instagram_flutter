import 'package:flutter/material.dart';
import './profile.dart';

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
          data[index]['image'].runtimeType == String
              ? Image.network(data[index]['image'], width: 500, height: 200)
              : Image.file(data[index]['image'], width: 500, height: 200),
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
                    GestureDetector(
                        child: Text('${data[index]['user']}',
                            style: TextStyle(color: Colors.grey)),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    ((context, animation, secondaryAnimation) =>
                                        Profile()),
                                transitionsBuilder: ((context, animation,
                                        secondaryAnimation, child) =>
                                    FadeTransition(
                                        opacity: animation, child: child)),
                                transitionDuration: Duration(milliseconds: 500),
                              ));
                        }),
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
