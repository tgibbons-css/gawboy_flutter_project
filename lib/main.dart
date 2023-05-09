import 'package:flutter/material.dart';
import 'package:kenburns/kenburns.dart';
import 'package:just_audio/just_audio.dart';

import 'datarepo.dart';
import 'dataitem.dart';

// This project was run on April 2023

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//class MyApp extends StatelessWidget {
class _MyAppState extends State<MyApp> {
  final PageController ctrl = PageController();

  DataRepo repo = new DataRepo();
  Future<List<DataItem>> futureItems;
  AudioPlayer player;
  bool languageState = true; // state is true for Anishinaabe and false for English

  @override
  void initState() {
    print("Inside initState");
    futureItems = repo.InitWithJson();
    player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playAudio(int index) async {
    await player.setAsset(repo.getJourdainAudio(index));
    player.play();
  }

  String getTextDescription(int index) {
    if (languageState) {
      return repo.getJourdainAnishinaabe(index);
    } else {
      return repo.getJourdainEnglish(index);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gawbay Ojibwe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('- Gawboy Art Slideshow -'),
          ),
          body: FutureBuilder<List<DataItem>>(
            future: futureItems,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("Inside FutureBuilder --- no data");
                // No data yet, show a loading spinner.
                return (Image.asset('assets/images/loading_image.gif',
                    fit: BoxFit.cover));
              } else {
                print("Inside FutureBuilder --- DATA");
                return myPageviewWidget();
              }
              ;
            },
          ),
        ));
  }

  PageView myPageviewWidget() {
    return PageView.builder(
      controller: ctrl,
      //itemCount: fileList.length,
      itemCount: repo.length(),
      itemBuilder: (context, index) {
        print("PageView Builder --- playing audio " + index.toString());
        playAudio(index);
        return Container(
          constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height),
          child: Stack(
              children: <Widget>[
                imageDisplayWidget(index),
                textDisplayWidget(index)
              ]),
        );
      },
    );
  }

  Container textDisplayWidget(int index) {
    return Container(
      alignment: FractionalOffset(0.6, 0.9),
      child: TextButton(
        onPressed: () {
          setState(() {
            print("----- text click -----");
            languageState = !languageState;
          });
        },
        child: Text(
          getTextDescription(index),
          textAlign: TextAlign.center,
          style: TextStyle(
            backgroundColor: Colors.blueGrey.withOpacity(.7),
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 36,
          ),
        ),
      ),
    );
  }

  KenBurns imageDisplayWidget(int index) {
    // Use the KenBurns widget to pan across the images
    // See https://pub.dev/packages/kenburns
    return KenBurns(
      maxScale: 2,
      minAnimationDuration: Duration(milliseconds: 10000),
      maxAnimationDuration: Duration(milliseconds: 20000),
      child: Image.asset(repo.getImageFile(index),
          fit: BoxFit.fitHeight, height: double.negativeInfinity),
    );
  }
}
