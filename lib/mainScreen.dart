import 'package:flutter/material.dart';
import 'mainScreenBody.dart';
import 'dataProviderClasses/dataListaPrincipale.dart';
import 'package:provider/provider.dart';

void addNote(BuildContext ctx){
  //ctx.read<ListaPrincipale>().RimuoviItem(0);

}

class mainScreen extends StatelessWidget{

  Widget build(BuildContext ctx){
    return MaterialApp(
                        theme: ThemeData(
                          primarySwatch: Colors.purple,
                          fontFamily: 'Quicksand',

                        ),
                        home: Scaffold(
                                        resizeToAvoidBottomInset:false,
                                        appBar: AppBar(
                                                  title: Text('Cose da fare [' + ctx.watch<ListaPrincipale>().quanteNote.toString() + ']'),
                                                  centerTitle: true,
                                                  actions: <Widget>[
                                                    IconButton(onPressed: null, icon: Icon(Icons.accessibility_new),)
                                                  ],
                                        ),
                                        body:   mainScreenBody(),
                          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
                          floatingActionButton: FloatingActionButton(onPressed: () => addNote(ctx) ,
                          child: Icon(Icons.home)),
                                      )
                      );
  }
}