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
            Text('Profile 화면임'),
          ],
        ));
  }
}
