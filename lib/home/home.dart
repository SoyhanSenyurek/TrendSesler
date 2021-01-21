import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:deneme_f/data/voice.dart';
import 'package:deneme_f/data/voice_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Voice> voices = VoiceData.getVoice();
  Duration _duration = Duration();
  Duration _position = Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("En iyi sesler"),
      ),
      body: Container(
          height: 160,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(voices.length, (index) {
              return listrow(voices[index]);
            }),
          )),
    );
  }

  Widget _btn(String txt, VoidCallback onPressed) {
    return ButtonTheme(
        minWidth: 50.0,
        child: Container(
          width: 80,
          height: 20,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Text(txt),
            color: Colors.pink[900],
            textColor: Colors.white,
            onPressed: onPressed,
          ),
        ));
  }

  listrow(voice) {
    return InkWell(
      child: Card(
        color: Colors.blue,
        child: Column(
          children: [
            Container(
              child:
                  Image.network(voice.UrlImage == null ? "" : voice.UrlImage),
              height: 60.0,
              width: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(
              height: 5,
            ),
            Text(voice.Ad),
            SizedBox(
              height: 5,
            ),
            _btn("Play", () => audioCache.play(voice.Url)),
            SizedBox(
              height: 5,
            ),
            _btn("Stop", () => advancedPlayer.stop()),
          ],
        ),
      ),
    );
  }
}
