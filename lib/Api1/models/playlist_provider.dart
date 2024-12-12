import 'package:api/Api1/models/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayListProvider extends ChangeNotifier {
  // play list of songs
  final List<Song> _playList = [

    Song(
        songName: "Malang Sajna",
        artistName: "sachet-parampara",
        albumArtImagePath: "https://c.saavncdn.com/400/Malang-Sajna-Hindi-2023-20230620141139-500x500.jpg",
        audioPath: "audio/Malang_Sajna.mp3"
    ),

    Song(
        songName: "Halki si Barsaat",
        artistName: "Manawar_Faruqui,Nazila_Saaj_Bhatt",
        albumArtImagePath: "https://www.wapking.cool/thumb/Aaja+Mere+Mahi+Teri+Yaad+Aa+Gayi+-+Saaj+Bhatt/600x600",
        audioPath: "audio/Aaja_Mere_Mahi_Teri_Yaad_Aa_Gayi.mp3"
    ),

    Song(
        songName: "Maan Meri Jaan",
        artistName: "Champagne_Talk_King",
        albumArtImagePath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW1MRiej_VbxMySmsG6-Ws6dE7a9STfryFWA&s",
        audioPath: "audio/Maan_Meri_Jaan.mp3"
    ),

  ];

  int? _currentSongIndex;

  // A U D I O - P L A Y E R

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlayListProvider(){
    listenToDuration();
  }

  // initialliy not playing
  bool _isPlaying = false;

  // play the song
  void Play() async{
    final String path = _playList[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path)); // play the new song
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void Pause() async{
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void Resume() async{
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async{
    if(_isPlaying){
      Pause();
    }else{
      Resume();
    }
    notifyListeners();
  }

  // seek to a specific position in the current song
  void Seek(Duration position) async{
    await _audioPlayer.seek(position);
  }

  // play next song
  void PlayNextSong(){
    if(_currentSongIndex != null){
      if(currentSongIndex! < _playList.length -1){
        // go o th next song if it's not last song
        currentSongIndex = _currentSongIndex! + 1;
      }else{
        // if it's last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void PlayPreviousSong() async{
    // if more than 2 seconds have passed, restart the current song
    if(_currentDuration.inSeconds > 2){
        Seek(duration,Zero);
    }
    // if it's within first 2 second of the song, go to previous song
    else{
      if(_currentSongIndex! > 0){
        currentSongIndex = currentSongIndex! - 1;
      }else{
        // if it's first song, loop back to last song
        currentSongIndex = _playList.length - 1;
      }
    }
  }
  // listen to duration
  void listenToDuration(){
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration){
      _totalDuration = newDuration;
      notifyListeners();
    });
    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition){
      _currentDuration = newPosition;
      notifyListeners();
    });
    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event){
      PlayNextSong();
      notifyListeners();
    });
  }
  // dispose audio player

  // G E T T E R S

  List<Song> get playlist => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // S E T T E R S

  set currentSongIndex(int? newIndex){
    // update song index
    _currentSongIndex = newIndex;
    if(newIndex != null){
      Play(); // play the song at the new index
    }
    // update UI
    notifyListeners();
  }

}
