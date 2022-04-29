import 'dart:convert';                      // needed for json convert
import 'package:flutter/services.dart';     // needed for folder location

import 'dataitem.dart';

class DataRepo {

  int length() {
    return items.length;
  }

  String getImageFile(int idx) {
    //return imageFilePrfix + imageFileList[idx];
    return imageFilePrfix + items[idx].imageFile;
  }

  String getGawboyAudioFile(int idx) {
    return audioFilePrfix + items[idx].gawboyAudio;
  }

  String getJourdainAudio(int idx) {
    return audioFilePrfix + items[idx].JourdainAudio;
  }

  String getImageTitle(int idx) {
    return items[idx].name;
  }

  String getJourdainAnishinaabe(int idx) {
    return items[idx].JourdainAnishinaabe;
  }

  String getJourdainEnglish(int idx) {
    return items[idx].JourdainEnglish;
  }


  final String imageFilePrfix = "assets/images/";
  final String audioFilePrfix = "assets/audio/";

  List<DataItem> items = [];

  Future<List<DataItem>> InitWithJson() async {
    final String response =  await rootBundle.loadString('assets/text/image_list2.json');

    final List<dynamic> data = await json.decode(response);
    items = [];
    for (dynamic it in data) {
      final DataItem item = DataItem.fromJson(it);    // Parse data for one DataItem
      items.add(item);                                // add item to items List
    }
    return items;
  }

  InitEmpty() {
    DataItem item = new DataItem(0, 'loading_image.gif', 'Loading', 'Loading from JSON');
    items.add(item);
  }

  InitInCode(){
    DataItem item = new DataItem(1,'by_the_fire_1.jpg', 'By the Fire', 'Chippewa Camp Scene');
    item.setGawboyDescription('The series of paintings in which fire light was kind of common theme.');
    items.add(item);

    item = new DataItem(2,'by_the_fire_2.jpg', 'By the Fire', 'Storyteller');
    item.setGawboyDescription('This is a cutout figure. It is painted on plywood and the plywood cutout kind of suggests a three dimensional form. This is a lady who is very good at telling stories sitting by the fire, her face is lit from underneath as she holding her audience spellbound.  In the foreground you can see some rocks. ');
    items.add(item);

    item = new DataItem(3,'by_the_fire_3.jpg', 'By the Fire', 'Joining the Women');
    item.setGawboyDescription('This is a girls coming of age ceremony just a part of it. The ceremony would be rather long lasting. In this painting the older women or older relatives telling her wisdom among other things herbal medicine, the duties of womanhood.');
    items.add(item);

    item = new DataItem(4,'by_the_fire_4.jpg', 'By the Fire', 'Joining the Women 2');
    item.setGawboyDescription('This was done on a plywood cut out. The plywood cut out was in a dome shape like a woman’s house and you have virtually the same type of scene.  ');
    items.add(item);

    item = new DataItem(5,'by_the_fire_5.jpg', 'By the Fire', 'Storyteller 2');
    item.setGawboyDescription('This is another piece from the Storyteller group. The Storyteller group is one of the other figurines, you see that same rock down there in the lower part of the slide. This is a plywood cut out about 8" high like the other one and this is one of the listeners to the Storyteller. ');
    items.add(item);

    item = new DataItem(6,'in_the_circle_1.jpg', 'In the Circle', 'Nanboujou and Mishipishu');
    item.setGawboyDescription('This was done in 1993.  The Nanboujou had wounded the great panther curly tail and the great panther offered the riches of world to anyone who could cure him.  ');
    items.add(item);

    item = new DataItem(7,'in_the_circle_2.jpg', 'In the Circle', 'Lowering the Flag, Ball Club');
    item.setGawboyDescription('This was done in 1993.  The Nanboujou had wounded the great panther curly tail and the great panther offered the riches of world to anyone who could cure him.  ');
    items.add(item);

    item = new DataItem(8,'in_the_circle_3.jpg', 'In the Circle', 'Veteran’s Farewell');
    item.setGawboyDescription('This was done in 1993.  The Nanboujou had wounded the great panther curly tail and the great panther offered the riches of world to anyone who could cure him.  ');
    items.add(item);
  }

  // See https://docs.flutter.dev/development/data-and-backend/json and https://www.kindacode.com/article/how-to-read-local-json-files-in-flutter/
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    items = data["items"];

  }



}