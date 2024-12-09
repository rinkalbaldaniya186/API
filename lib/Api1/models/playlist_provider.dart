import 'package:api/Api1/models/song.dart';
import 'package:flutter/material.dart';

class PlayListProvider extends ChangeNotifier {
  // play list of songs
  final List<Song> _playList = [

    Song(
        songName: "Malang Sajna",
        artistName: "sachet-parampara",
        albumArtImagePath: "images/malang_sajna.jfif",
        audioPath: "audio/Malang_Sajna.mp3"
    ),
  ];

  int? _currentSongIndex;

  List<Song> get playlist => _playList;
  int? get currentSongIndex => _currentSongIndex;

}