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
        albumArtImagePath: "https://www.wapking.cool/thumb/Aaja+Mere+Mahi+Teri+Yaad+Aa+Gayi+-+Saaj+Bhatt/500x500",
        audioPath: "audio/Aaja_Mere_Mahi_Teri_Yaad_Aa_Gayi.mp3"
    ),

    Song(
        songName: "Maan Meri Jaan",
        artistName: "Champagne_Talk_King",
        albumArtImagePath: "https://static.qobuz.com/images/covers/bb/rr/quwew7sjwrrbb_600.jpg",
        audioPath: "audio/Maan_Meri_Jaan.mp3"
    ),

    Song(
        songName: "Kaho na pyar hai",
        artistName: "Shahrukh Khan,Kajol,Rani Udit Narayan",
        albumArtImagePath: "https://s.saregama.tech/image/c/fw_500/1/fa/ae/kaho-naa-pyar-hai_1440x1440_1632901612.jpg",
        audioPath: "audio/Kaho_Na_Pyar_Hai.mp3"
    ),

    Song(
        songName: "Kamariya",
        artistName: "Mitron Jackky Bhagnani, Kritika Kamra, Darshan Raval",
        albumArtImagePath: "https://cdn-images.dzcdn.net/images/cover/e377125b96e6ff6a5f69dc730f38ff3f/0x1900-000000-80-0-0.jpg",
        audioPath: "audio/Kamariya.mp3",
    ),

    Song(
        songName: "Chale Aana",
        artistName: "AjayDevgn,Tabu, Rakul Preet, Amaal Mallik, Kunaal",
        albumArtImagePath: "https://m.media-amazon.com/images/M/MV5BNGNjZmI5ZjAtMTZmOS00MGYyLTg1OGMtNTk0NDAwNjU1ZjhiXkEyXkFqcGc@._V1_UY500_UX500_.jpg",
        audioPath: "audio/CHALE_AANA.mp3"
    ),

    Song(
        songName: "Akhiyaan Gulaab",
        artistName: "Shahid Kapoor,Kriti Sanon, Mitraz",
        albumArtImagePath: "https://i.scdn.co/image/ab67616d0000b273dfa8e0dab093f6a7c638c7fc",
        audioPath: "audio/Akhiyaan_Gulaab.mp3"
    ),

    Song(
        songName: "Barbaadiyan(Shiddat)",
        artistName: "Sunny K,Radhika M Sachet T,Nikhita G, Madhubanti B Sachin- Jigar",
        albumArtImagePath: "https://i1.sndcdn.com/artworks-nUJumEgxA52TdRBM-8G0zBA-t500x500.jpg",
        audioPath: "audio/Barbaadiyan.mp3"
    ),

    Song(
        songName: "Kabhi Shaam Dhale",
        artistName: "Mohammad Faiz, Jaani, Kedrock,",
        albumArtImagePath: "https://static.qobuz.com/images/covers/bb/u6/xsgqoknegu6bb_600.jpg",
        audioPath: "audio/Kabhi_Shaam_Dhale.mp3"
    ),

    Song(
        songName: "Main nikla gaddi leke",
        artistName: "Udit narayan, Aditya narayan, Mithoon, Uttam singh",
        albumArtImagePath: "https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/ce/b6/8a/ceb68a85-86d6-10e7-a65f-1aae1a26402e/840214495854.png/1200x1200bf-60.jpg",
        audioPath: "audio/Bas_Ek_Nazar_Usko_Dekha.mp3"
    ),

    Song(
        songName: "Jab Tum Aa Jaate Ho Samne",
        artistName: " Kavita Krishnamurthy and Sonu Nigam",
        albumArtImagePath: "https://c.saavncdn.com/336/Maharaja-Hindi-2021-20241007202112-500x500.jpg",
        audioPath: "audio/Jab Tum Aa Jaate Hoe.mp3"
    ),

    Song(
        songName: "Koi Mil Gaya",
        artistName: "Shah Rukh Khan,Kajol, Rani Udit Narayan",
        albumArtImagePath: "https://m.media-amazon.com/images/I/516H3SI5htL._UXNaN_FMjpg_QL85_.jpg",
        audioPath: "audio/Koi_Mil_Gaya.mp3"
    ),

    // Song(
    //     songName: "Sanam Teri Kasam",
    //     artistName: "Ankit Tiwari, Palak Muchhal",
    //     albumArtImagePath: "https://c.saavncdn.com/820/Sanam-Teri-Kasam-Hindi-2016-20230430081750-500x500.jpg",
    //     audioPath: "audio/Sanam_Teri_Kasam_Jukebox_All_Songs.m4a"
    // ),

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
      Seek(Duration.zero);
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