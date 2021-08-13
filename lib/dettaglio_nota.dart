import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'dataProviderClasses/dataListaPrincipale.dart';
import 'package:provider/provider.dart';

class dettaglioNota extends StatelessWidget{

  final myItem;

  dettaglioNota(this.myItem);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
      bottomNavigationBar:
        Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: CircleAvatar(child: Icon(Icons.arrow_back)
            ),
          ),
        ],
      ),
        body: Container(
          height: double.infinity,
          child: Flexible(
            fit: FlexFit.tight,
            child: Column(
              children: [
                SizedBox(height: 50,),
                Card(
                  shape: RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.circular(30)),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    color: Theme.of(context).primaryColorLight,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      SizedBox(height: 40.0),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                  shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.blueGrey, width: 1),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("CREATA il " + DateFormat('yyyy-MM-dd').format(myItem.added),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.0,
                                        color: Theme.of(context).primaryColor,
                                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                        fontFamily: 'Quicksand'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Row(
                          children: [
                            Text('Scadenza:'),
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.blueGrey, width: 1),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(DateFormat('yyyy-MM-dd').format(myItem.due),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      backgroundColor: Colors.white,
                                      fontFamily: 'Courier'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Titolo         '),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Card(
                                shadowColor: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.blueGrey, width: 1),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),

                                child:

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(myItem.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        backgroundColor: Colors.white,
                                        fontFamily: 'Verdana'),
                                ),
                              ),
                  ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Text('Dettagli     '),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.blueGrey, width: 1),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(myItem.desc,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        backgroundColor: Colors.white,
                                        fontFamily: 'Verdana'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 60.0,),
                      //Image.asset("assets/images/biki.jpg", fit: BoxFit.fitWidth),
                      ],

                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

}