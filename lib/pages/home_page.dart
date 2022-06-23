import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefas_2022/models/tarefa.dart';
import 'package:lista_tarefas_2022/repositories/respository_tarefa.dart';
import 'package:lista_tarefas_2022/widgets/item_lista_tarefas.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //atributos
  final RepositoryTarefa _repositoryTarefa = RepositoryTarefa();
  final _tarefaControler = TextEditingController();
  List<Tarefa> _listaTarefas = [];
  Tarefa? _tarefaDeletada;
  int? _posicaoTarefaDeletada;
  String? _errorText;

  @override
  void initState() {
    //pede a lista de tarefas, e assim q o metodo getListaTarefas retornar esta lista, vai passala para a lista _listaTarefas
    _repositoryTarefa.getListaTarefas().then((value) {
      setState(() {
        _listaTarefas = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        gradient: LinearGradient(
          colors: [
            Colors.cyan,
            Colors.indigo,
          ],
          /*
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.red,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)

          ),
           */
        ),

        title: Text(
          'Lista de Tarefas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _tarefaControler,
                          decoration: InputDecoration(
                            labelText: "Adicione uma tarefa",
                            hintText: "Ex: Estudar",
                            errorText: _errorText,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff00d7f3),
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xff00d7f3),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String texto = _tarefaControler.text;
                          if (texto.isEmpty) {
                            setState(() {
                              _errorText = "O campo não pode ser vazio!";
                            });
                            return;
                          }
                          setState(() {
                            Tarefa novaTarefa = Tarefa(
                                titulo: _tarefaControler.text,
                                data: DateTime.now());
                            _listaTarefas.add(novaTarefa);
                            _errorText = null;
                            _tarefaControler.clear();
                            _repositoryTarefa.saveTarefaList(
                                _listaTarefas); //salva alista de tarefas no dispositivo
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(14),
                          primary: Color(0xff00d7f3),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    //para a lista ocupar o maximo de altura que a tela deixar
                    child: ListView(
                      shrinkWrap: true,
                      //define a altura da ListView de acordo com o numero de itens
                      children: [
                        for (Tarefa tarefa in _listaTarefas)
                          ItemListaTarefas(
                            tarefa: tarefa,
                            delerarTarefa: delerarTarefa,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                            "Você possui ${_listaTarefas.length} tarefas pendentes!"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: deletarTodasAsTarefas,
                        child: Text("Limpar Tudo"),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff00d7f3),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  delerarTarefa(Tarefa tarefa) {
    _tarefaDeletada = tarefa;
    _posicaoTarefaDeletada = _listaTarefas.indexOf(
        tarefa); //armazena o indice da lista onde se encontra a tarefa q vai ser deletada

    setState(() {
      _listaTarefas.remove(tarefa); //remove a tarefa da lista
      _repositoryTarefa.saveTarefaList(_listaTarefas); //salva a lista
    });

    ScaffoldMessenger.of(context).clearSnackBars(); //apaga as SnackBars abertas
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("Tarefa ${tarefa.titulo} foi removida com sucesso!"),
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Desfazer',
            textColor: Color(0xff00d7f3),
            onPressed: () {
              setState(() {
                _listaTarefas.insert(_posicaoTarefaDeletada!,
                    _tarefaDeletada!); //insere a tarefa na lista na posicao indicada
                _repositoryTarefa.saveTarefaList(_listaTarefas); //salva a lista
              });
            },
          )),
    );
  }

  deletarTodasAsTarefas() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Limpar Tudo?"),
        content: SizedBox(
          height: 131,
          width: 100,
          child: Image.asset("assets/gifs/vassoura1.gif"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); //fecha o AlertDialog
            },
            style: TextButton.styleFrom(
              primary: Color(0xff00d7f3),
            ),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _listaTarefas.clear(); //limpa a lista
                _repositoryTarefa.saveTarefaList(_listaTarefas); //salva a lista
              });
              Navigator.of(context).pop(); //fecha o AlertDialog
            },
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
            child: Text("Limpar Tudo"),
          ),
        ],
      ),
    );
  }
}
