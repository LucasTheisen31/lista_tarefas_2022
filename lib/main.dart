
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefas_2022/pages/home_page.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
       //statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.cyan,
        statusBarColor: Colors.transparent,//deixar a bara de status da mesma cor do app, transparente
        //systemNavigationBarColor: Colors.purple[800],//cor da barra de navegacao(barra dos botoes do android na parte de baixo da tela)
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}




