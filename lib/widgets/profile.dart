import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/store_ex.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.watch<StoreEx>().name)),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                ),
                Text('팔로워 ${context.watch<StoreEx>().follower}명'),
                ElevatedButton(
                    onPressed: () {
                      context.read<StoreEx>().changeFollower();
                    },
                    child: Text('팔로우'))
              ],
            ),
            SizedBox.shrink(),
            ElevatedButton(
              onPressed: () {
                context.read<StoreEx2>().getData();
              },
              child: Text('사진 가져오기'),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return Image.network(context.watch<StoreEx2>().images[i]);
                },
                itemCount: context.watch<StoreEx2>().images.length,
              ),
            )
          ],
        ));
  }
}
