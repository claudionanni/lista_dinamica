import 'package:flutter/material.dart';
import 'dataProviderClasses/dataListaPrincipale.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'mainScreenList.dart';

class mainScreenBody extends StatelessWidget {
  static bool appJustLoaded = true;
  final ctrTextTitle = TextEditingController();
  final ctrTextDesc = TextEditingController();
  final ctrTextDue = TextEditingController();
  final ctrItemCount = TextEditingController(text: '0');

  //DateTime dueDate=DateTime.now();

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
        context: ctx,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 8),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      //dueDate=picked;
      ctrTextDue.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  _clearForm(BuildContext ctx) {
    ctrTextTitle.clear();
    ctrTextDesc.clear();
    ctrTextDue.clear();
  }

  Widget build(BuildContext ctx) {
    if (appJustLoaded) {
      ctx.watch<ListaPrincipale>().LoadDataLocally();
      appJustLoaded = false;
    }
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(children: [
        Card(
          color: Colors.white70,
          shadowColor: Colors.black12,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextField(
                        focusNode: null,
                        autofocus: false,
                        autocorrect: true,
                        cursorColor: Theme.of(ctx).errorColor,
                        controller: ctrTextTitle,
                        decoration: InputDecoration(
                            labelText: 'Titolo',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            fillColor: Colors.white,
                            filled: true),
                        enabled: true,
                      ),
                      width: 150,
                    ),
                  ),
                ],
              ),
              Container(
                child: TextField(
                  focusNode: null,
                  autocorrect: true,
                  cursorColor: Theme.of(ctx).errorColor,
                  controller: ctrTextDesc,
                  decoration: InputDecoration(labelText: 'Dettagli'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: ctrTextDue,
                        decoration: InputDecoration(labelText: 'Quando'),
                        enabled: false,
                      ),
                      width: 150,
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () => _selectDate(ctx),
                      icon: CircleAvatar(child: Icon(Icons.calendar_today_outlined)),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
        Container(
          color: Theme.of(ctx).dividerColor,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
              tooltip: 'Aggiungi Nota',
              onPressed: () => ctx.read<ListaPrincipale>().AggiungiItem(ListItem(
                    title: ctrTextTitle.text,
                    desc: ctrTextDesc.text,
                    added: DateTime.now(),
                    due: DateTime.parse(ctrTextDue.text),
                  )),
              icon: CircleAvatar(
                child: Icon(Icons.add),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            //ElevatedButton(onPressed: () => _selectDate(ctx), child: Text("Data di esecuzione"),),
            IconButton(
              tooltip: 'Pulisci form',
              icon: CircleAvatar(
                child: Icon(Icons.clear_all),
              ),
              onPressed: () => _clearForm(ctx),
            ),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blueGrey, width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(''),
              ),
            ),

            /*ElevatedButton(
              onPressed: () => ctx.read<ListaPrincipale>().SaveDataLocally(),
              child: Text("Salva Note"),
            ),
            ElevatedButton(
              onPressed: () => ctx.read<ListaPrincipale>().LoadDataLocally(),
              child: Text("Carica Note"),
            ),*/
            //TextField(controller: ctrTextDue),
          ]),
        ),
        mainScreenList(),
      ]),
    );
  }
}
