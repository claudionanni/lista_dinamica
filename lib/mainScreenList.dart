import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lista_dinamica/dettaglio_nota.dart';
import 'dataProviderClasses/dataListaPrincipale.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class mainScreenList extends StatelessWidget {
  // Return a color based on the expiration date of a Note:
  // Red: Expired
  // Yellow: Expiring whitin 3 days
  // Green: Expiring later than 3 days
  Color colorFromDate(DateTime dt) {
    var myColor = Colors.green;
    if (DateTime.now().isAfter(dt)) {
      myColor = Colors.red;
    } else if (DateTime.now().add(Duration(days: 3)).isAfter(dt)) {
      myColor = Colors.yellow;
    }
    return myColor;
  }

  Widget build(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 400,
      child: Flexible(
        fit: FlexFit.tight,
        child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(), borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.hardEdge,
          child: ListView.builder(
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.all(5),
              physics: AlwaysScrollableScrollPhysics(),
              reverse: true,
              shrinkWrap: true,
              itemCount: ctx.watch<ListaPrincipale>().quanteNote,
              itemBuilder: (ctx, int index) {
                return Card(
                    child: ListTile(
                  //leading: CircleAvatar(child: Icon(Icons.document_scanner_rounded),),
                  leading: CircleAvatar(
                    child: Text(DateFormat('dd/MM')
                        .format(ctx.watch<ListaPrincipale>().Notes[index].due)),
                    radius: 25,
                    backgroundColor: colorFromDate(
                        ctx.watch<ListaPrincipale>().Notes[index].due),
                    foregroundColor: Colors.black,
                  ),
                  //onLongPress: () =>
                  //    ctx.read<ListaPrincipale>().RimuoviItem(index),
                  onTap: () => Navigator.push(
                    ctx,
                    MaterialPageRoute(
                        builder: (ctx) => dettaglioNota(
                            ctx.watch<ListaPrincipale>().Notes[index])),
                  ),
                  title: Text(ctx.watch<ListaPrincipale>().Notes[index].title),
                  subtitle: Text(
                    ctx.watch<ListaPrincipale>().Notes[index].desc +
                        "\nCreata: " +
                        DateFormat('yyyy-MM-dd').format(
                            ctx.watch<ListaPrincipale>().Notes[index].added),
                    /*" - Da fare: " +
                  DateFormat('yyyy-MM-dd')
                      .format(ctx.watch<ListaPrincipale>().Notes[index].due))*/
                  ),
                  tileColor: Colors.black12,
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(ctx).indicatorColor,
                    onPressed: () {
                      ctx.read<ListaPrincipale>().RimuoviItem(index);
                    },
                  ),
                ));
              }),
        ),
      ),
    );
  }
}
