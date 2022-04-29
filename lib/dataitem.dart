class DataItem {

  int num;
  String imageFile;
  String catagory;
  String name;
  String gawboyDescription;
  String gawboyAudio;
  String JourdainAnishinaabe;
  String JourdainEnglish;
  String JourdainAudio;

  DataItem(this.num, this.imageFile, this.catagory, this.name);
  /*
  DataItem(int num, String imageFile, String category, String name){
    this.num = num;
    this.imageFile = imageFile;
    this.catagory = category;
    this.name = name;
  }
  */

  DataItem.fromJson(Map<String, dynamic> json)
      : num = json['num'],
        imageFile = json['imageFile'],
        catagory = json['catagory'],
        name = json['name'],
        gawboyDescription = json['gawboyDescription'],
        gawboyAudio = json['gawboyAudio'],
        JourdainAnishinaabe = json['JourdainAnishinaabe'],
        JourdainEnglish = json['JourdainEnglish'],
        JourdainAudio = json['JourdainAudio'];

  Map<String, dynamic> toJson() => {
    'num': num,
    'imageFile': imageFile,
    'catagory': catagory,
    'name': name,
    'gawboyDescription': gawboyDescription,
    'gawboyAudio': gawboyAudio,
    'JourdainAnishinaabe': JourdainAnishinaabe,
    'JourdainEnglish': JourdainEnglish,
    'JourdainAudio': JourdainAudio,
  };

  setGawboyDescription(String newDescription) {
    gawboyDescription = newDescription;
  }

  setGawboyAudio(String newgawboyAudio) {
    gawboyAudio = newgawboyAudio;
  }

}
