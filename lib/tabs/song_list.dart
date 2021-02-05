import 'package:deneme_f/widget/FutureList.dart';
import 'package:flutter/material.dart';

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureVoiceList(1);
  }
}
