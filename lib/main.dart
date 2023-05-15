import 'package:flutter/material.dart';
import 'package:kenburns/kenburns.dart';
import 'package:just_audio/just_audio.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';


import 'datarepo.dart';
import 'dataitem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CarouselController _carouselController = CarouselController();

  DataRepo repo = new DataRepo();
  Future<List<DataItem>> futureItems;
  AudioPlayer player;
 // bool languageState = true; // state is true for Anishinaabe and false for English


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

  // String getTextDescription(int index) {
  //   if (languageState) {
  //     return repo.getJourdainAnishinaabe(index);
  //   } else {
  //     return repo.getJourdainEnglish(index);
  //   }
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '- Gawbay Ojibwe -',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('- Gawboy Art Slideshow -'),
            centerTitle: true,
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
                return myCarouselSliderWidget(snapshot.data);
              }
            },
          ),
        ));
  }

  CarouselSlider myCarouselSliderWidget(List<DataItem> items) {
    return CarouselSlider.builder(
      itemCount: items.length,
      carouselController: _carouselController,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        print("Carousel Builder --- playing audio " + index.toString());

        return Container(
          constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height),
          child: Stack(
              children: <Widget>[
                imageDisplayWidget(index),
                textDisplayWidget(index),
                textDisplayWidgetOpposite(index),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: floatingActionButtonPrevious(),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: floatingActionButtonNext(index),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: floatingActionButtonAudio(index),
                    ),
                  ],
                ),
              ]),
        );
      },
      options: CarouselOptions(
        height: double.maxFinite,
        aspectRatio: 9/9,
        viewportFraction: 1.0,
        autoPlay: false,//a change
        autoPlayInterval: Duration(seconds: 10),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
    );
  }

  FloatingActionButton floatingActionButtonAudio(int index){
    return FloatingActionButton(
      onPressed: () => playAudio(index),
      child: Text('Sound'),
      backgroundColor: Colors.green,

    );
  }
  Container textDisplayWidget(int index) {
    return Container(
        alignment: FractionalOffset.bottomCenter,
        child: TextButton(
        onPressed: () {
      setState(() {
        print("----- text click -----");
        //languageState = !languageState;
      });
        },
          child: Text(
            repo.getJourdainAnishinaabe(index),
            textAlign: TextAlign.center,
            style: TextStyle(
              backgroundColor: Colors.blueGrey.withOpacity(.6),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 36,
            ),
          ),
        ),
    );
  }

  FloatingActionButton floatingActionButtonNext(index)
  {
    return FloatingActionButton(
      // onPressed: () => _carouselController.nextPage(
      //     duration: Duration(milliseconds: 300), curve: Curves.linear),
      onPressed: () async{
        await _carouselController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.linear);
          player.stop();
      },
      child: Text('->'),
      backgroundColor: Colors.red,

    );
  }
  FloatingActionButton floatingActionButtonPrevious()
  {
    return FloatingActionButton(
      onPressed: () async{
        await _carouselController.previousPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear);
        player.stop();
      },
      child: Text('<-'),
      backgroundColor: Colors.blue,
      elevation: 0,

    );
  }

  Container textDisplayWidgetOpposite(int index) {
    return Container(
      alignment: FractionalOffset.topCenter,
      child: TextButton(
        onPressed: () {
          setState(() {
            print("----- text click -----");
            //languageState = !languageState;
          });
        },
        child: Text(
          repo.getJourdainEnglish(index),
          textAlign: TextAlign.center,
          style: TextStyle(
            backgroundColor: Colors.blueGrey.withOpacity(.6),
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
      //minAnimationDuration: Duration(milliseconds: 10000),
      //maxAnimationDuration: Duration(milliseconds: 20000),
      child: Image.asset(repo.getImageFile(index),
          fit: BoxFit.fitHeight, height: double.negativeInfinity),
    );
  }
}



/*
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
        title: '- Gawbay Ojibwe -',
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
      alignment: Alignment.bottomCenter,
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
            backgroundColor: Colors.blueGrey.withOpacity(.6),
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
*/