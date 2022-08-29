import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instagram_test/store/store_ex.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
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
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              context.read<StoreEx2>().getData();
            },
            child: Text('사진 가져오기'),
          ),
        ),
      ],
    );
  }
}
