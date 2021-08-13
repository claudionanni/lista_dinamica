import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Class containing a single list Item
class ListItem {
  String title='';
  String desc='';
  DateTime added=DateTime.now();
  DateTime due=DateTime.now();

  ListItem({required this.title, required this.desc, required this.added, required this.due});

  ListItem.fromList({required List<String> lItem}){
    this.title=lItem[0];
    this.desc=lItem[1];
    this.added=DateTime.parse(lItem[2]);
    this.due=DateTime.parse(lItem[3]);
  }

  Map<String, dynamic> jsonizeItem(){
    return jsonDecode('{"title": "' + this.title + '", "desc": "' + this.desc + '", "added": "' + this.added.toString() + '", "due": "' + this.due.toString() + '"}');
  }
  List<String> listifyItem(){
    return [title,desc,added.toString(),due.toString()];
  }
}

// Lista principale: Una Lista/Vettore di ListItem
class ListaPrincipale extends ChangeNotifier{
  int _id=0;
  String _title='';
  String _desc='';
  DateTime _added=DateTime.now();
  DateTime _due=DateTime.now();


  List<ListItem> _Notes=<ListItem>[];

  // Getters
  List<ListItem> get Notes => _Notes;
  int get quanteNote => _Notes.length;
  // These are only to hold temporary values in a centralized place for currently edited fields on the UI
  /*DateTime get added => _added;
  DateTime get due => _due;
  String get title => _title;
  String get desc => _desc;*/

  // Methods
  void AggiungiItem(ListItem pItem){
    _Notes.add(pItem);
    // Everytime I add an item I sort the list
    _Notes.sort((a,b) {
      var adate = a.due; //before -> var adate = a.expiry;
      var bdate = b.due; //var bdate = b.expiry;
      return -adate.compareTo(bdate);
    });
    SaveDataLocally();
    notifyListeners();
  }

  void RimuoviItem(int index) async {
    _Notes.removeAt(index);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("L"+index.toString());
    print("Removed item " + index.toString());
    SaveDataLocally();
    notifyListeners();
  }

  void set_due(DateTime pDue){
    _due=pDue;
  }


  void SaveDataLocally() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    //int counter = (prefs.getInt('quanteNote') ?? 0)+1;
    //print("Contatore da sharedpref: " + counter.toString());
    for(var li = 0; li < this._Notes.length; li++){
        //Map<String, dynamic> jsonizedItem=this._Notes[li].jsonizeItem();
        String id="L"+li.toString();
        print(id);
        prefs.setStringList(id, this._Notes[li].listifyItem());
    }
    prefs.setInt('quanteNote',this.quanteNote);
    print(this.quanteNote);
  }

  LoadDataLocally() async {
    SharedPreferences prefsRead = await SharedPreferences.getInstance();
    //int counter = (prefsRead.getInt('quanteNote') ?? 0);
    print("Leggendo da disco le note salvate");
    int counter = (prefsRead.getInt('quanteNote') ?? 0);
    print("Contatore su disco dice: " + counter.toString());
    _Notes.clear();
    for(var li = 0; li < counter; li++) {
      print(li.toString());
      List<String> oneItem=(prefsRead.getStringList("L"+li.toString()) ?? ['','','','']);
      ListItem lit=new ListItem.fromList(lItem: oneItem );
      _Notes.add(lit);
      print(lit.title);
    }
    notifyListeners();
  }

 /*Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
}

Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/pippo.txt');
}*/

}