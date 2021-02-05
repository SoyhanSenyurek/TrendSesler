import 'package:deneme_f/tabs/favorite_list.dart';
import 'package:deneme_f/tabs/song_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Anasayfa",
              ),
              Tab(
                text: "Sık Kullanılan",
              )
            ],
          ),
          title: Text(
            "Trend Sesler",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [SongList(), FavoriteList()],
        ));
  }
}
