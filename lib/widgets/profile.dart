import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instagram_test/store/store_ex.dart';
import 'package:instagram_test/widgets/profile_header.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.watch<StoreEx>().name)),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: ProfileHeader()),
            SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                delegate: SliverChildBuilderDelegate(
                  (context, idx) {
                    return Image.network(context.watch<StoreEx2>().images[idx]);
                  },
                  childCount: context.watch<StoreEx2>().images.length,
                )),
          ],
        ));
  }
}
