import 'package:api/Api1/models/playlist_provider.dart';
import 'package:api/Api1/models/song.dart';
import 'package:api/Api1/pages/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("P L A Y L I S T"),
      ),
      drawer: MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child){
          // get the play list
          final List<Song> playlist = value.playlist;

          // return list view UI
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index){

              // get individual song
              final Song song = playlist[index];
              // return list tile UI

              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
              );
            }
          );
        }
      ),
    );
  }
}
