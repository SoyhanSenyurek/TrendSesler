import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme_f/database/db_help.dart';
import 'package:deneme_f/database/favorite.dart';
import 'package:flutter/material.dart';
import 'package:music_player/music_player.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FutureVoiceList extends StatefulWidget {
  int _screenId;
  FutureVoiceList(int screenId) {
    _screenId = screenId;
  }
  @override
  _FutureVoiceListState createState() => _FutureVoiceListState(_screenId);
}

class _FutureVoiceListState extends State<FutureVoiceList> {
  int _screenId;
  _FutureVoiceListState(screenId) {
    _screenId = screenId;
  }
  MusicPlayer player;
  DbHelper _dbHelper;
  List<int> listID = new List<int>();

  void updateRating(rating, ad) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('sesler');

    QuerySnapshot querySnapshot =
        await collectionReference.where("ad", isEqualTo: ad).get();

    var ratingDatabase = querySnapshot.docs[0].data()["rating"];
    var ratingCountDatabase = querySnapshot.docs[0].data()["ratingCount"];

    var ratingResult = ((ratingCountDatabase * ratingDatabase) + rating) /
        (ratingCountDatabase + 1);
    Map<String, dynamic> ratingData = {
      "rating": ratingResult,
      "ratingCount": ratingCountDatabase + 1
    };
    querySnapshot.docs[0].reference.update(ratingData);
  }

  Future getData() async {
    QuerySnapshot qn;
    if (_screenId == 2) {
      if (listID.length > 0) {
        qn = await Firestore.instance
            .collection("sesler")
            .where("id", whereIn: listID)
            .getDocuments();
      }
    } else {
      qn = await Firestore.instance.collection("sesler").getDocuments();
    }

    return qn.docs;
  }

  void getFavoriteList() async {
    var favoriteList = await _dbHelper.getFavorite();
    if (favoriteList.length > 0) {
      for (var i = 0; i < favoriteList.length; i++) {
        setState(() {
          listID.add(favoriteList[i].firebaseId);
        });
      }
    }
  }

  @override
  void initState() {
    initPlayer();
    getFavoriteList();
    super.initState();
  }

  void initPlayer() {
    player = MusicPlayer();
    _dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(listID.contains(snapshot.data[index].data()["id"])
                      ? Icons.star_rounded
                      : Icons.star_outline),
                  iconSize: 30,
                  color: Colors.black,
                  onPressed: () async {
                    int firebaseId = snapshot.data[index].data()["id"];
                    var context = Favorite(firebaseId: firebaseId);
                    if (listID.contains(firebaseId)) {
                      await _dbHelper.deleteFavorite(context);
                      setState(() {
                        listID.remove(firebaseId);
                      });
                    } else {
                      await _dbHelper.insertFavorite(context);
                      setState(() {
                        listID.add(firebaseId);
                      });
                    }
                  },
                ),
                title: Text(
                  snapshot.data[index].data()["ad"],
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                subtitle: SmoothStarRating(
                  starCount: 5,
                  allowHalfRating: false,
                  borderColor: Colors.black,
                  color: Colors.red,
                  onRated: (rating) {
                    updateRating(rating, snapshot.data[index].data()["ad"]);
                  },
                ),
                contentPadding: EdgeInsets.all(10),
                selectedTileColor: Colors.blue,
                tileColor: Colors.cyan,
                trailing: Container(
                  child: Wrap(
                    spacing: 12,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                          ),
                          color: Colors.green,
                          iconSize: 30,
                          onPressed: () {
                            player.play(MusicItem(
                                url: snapshot.data[index].data()["sesurl"],
                                trackName: "Sample",
                                artistName: "Sample",
                                albumName: "Sample",
                                duration: Duration(seconds: 255)));
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.stop_sharp,
                          ),
                          iconSize: 30,
                          color: Colors.red,
                          onPressed: () {
                            player.stop();
                          }),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
