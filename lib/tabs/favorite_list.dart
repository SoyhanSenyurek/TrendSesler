import 'package:deneme_f/widget/FutureList.dart';
import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return FutureVoiceList(2);
  }
}
