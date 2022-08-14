import 'package:flutter/material.dart';

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
          userImage == null
              ? SizedBox.shrink()
              : Image.file(userImage, width: 500, height: 200),
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
            Navigator.pop(context);
          }, child: Text('Upload')),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
        ]));
  }
}