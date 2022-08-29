import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoreEx extends ChangeNotifier {
  var name = 'Minjun';
  var follower = 0;
  var isFollowed = false;
  changeFollower() {
    if (!isFollowed) {
      follower++;
      isFollowed = true;
    } else {
      follower--;
      isFollowed = false;
    }

    notifyListeners();
  }
}

class StoreEx2 extends ChangeNotifier {
  var images = [];

  getData() async {
    var data = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var decodedData = jsonDecode(data.body);
    images = decodedData;
    notifyListeners();
  }
}
