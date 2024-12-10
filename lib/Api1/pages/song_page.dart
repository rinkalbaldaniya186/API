import 'dart:ffi';

import 'package:api/Api1/componets/neu_box.dart';
import 'package:api/Api1/models/playlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});
  // convert duration into min:seconds

  String FormateTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes} : $twoDigitSeconds";

    return formattedTime;
  }

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (context, value, child) {
        //get playlist
        final playList = value.playlist;
        // get current song index
        final currentSong = playList[value.currentSongIndex ?? 0];
        // return scaffold UI
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // appbar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // back botton
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)
                        ),
                        // title
                        Text("P L A Y I S T"),
                        //menu button
                        IconButton(
                            onPressed: () {

                            },
                            icon: Icon(Icons.menu)
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // album art work
                    NeuBox(
                      child: Column(
                        children: [
                          // image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(currentSong.albumArtImagePath),
                          ),
                          // Song and Artist Name and Icon
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Song and Artist Name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                     currentSong.songName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),
                                    ),
                                    Text(currentSong.artistName),
                                  ],
                                ),
                                // Heart
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    // song duration progress
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Start Time
                              Text(formateTime(value.currentDuration)),
                              // Shuffle Icon
                              Icon(Icons.shuffle),
                              // Repeat Icon
                              Icon(Icons.repeat),
                              // End Time
                              Text(FormateTime(value.totalDuration)),
                            ],
                          ),
                        ),
                        // Song Duration Progress
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 0
                            ),
                          ),
                          child: Slider(
                            min: 0,
                            max: value.totalDuration.inSeconds.toDouble(),
                            value: value.currentDuration.inSeconds.toDouble(),
                            activeColor: Colors.green,
                            onChanged: (double double) {
                              // during when the user is sliding around
                            },
                            onChangeEnd: (double double) {
                              // sliding has finished, go to that position in song duration
                              value.Seek(Duration(seconds: double.toInt()));
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // playback ,Controllers
                    Row(
                      children: [
                        // skip previous
                        Expanded(
                          child: GestureDetector(
                            onTap: value.PlayPreviousSong,
                            child: NeuBox(
                                child: Icon(Icons.skip_previous)
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        // play pause
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                                child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow)
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        // skip forward
                        Expanded(
                          child: GestureDetector(
                            onTap: value.PlayNextSong,
                            child: NeuBox(
                                child: Icon(Icons.skip_next)
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
        );
      }
    );
  }
}
