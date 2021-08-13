import 'package:flutter/material.dart';
import 'package:lista_dinamica/mainScreen.dart';
import './dataProviderClasses/dataListaPrincipale.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers:
              [
                ChangeNotifierProvider(create: (_)=>ListaPrincipale()),
              ],
         child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return mainScreen();
  }
}

