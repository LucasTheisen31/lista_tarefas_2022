import 'dart:convert';

import 'package:lista_tarefas_2022/models/tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepositoryTarefa {

  //atributos
  late SharedPreferences _prefs;

  //metodos

  Future<List<Tarefa>> getListaTarefas() async {
    _prefs = await SharedPreferences.getInstance();//pega a instancia do SharedPreferences
    final String lista = _prefs.getString('lista_tarefas') ?? '[]';//se a lista for nula retorna '[]'
    List listaDecodificada = json.decode(lista) as List;//decodifica a lista que esta em formato Json para uma lista
    return listaDecodificada.map((e) => Tarefa.fromjson(e)).toList();/*Tarefa.fromjson(e) é o construtor da classe tarefa
    que instancia um objeto a partir de um mapa, (e) é o objeto que é passado em forma de mapa para o construtor que ira instanciar um objeto,
    e depois de instanciar os objetos transforma eles em uma lista que é retornada neste metodo*/
  }

  saveTarefaList(List<Tarefa> listaTarefas){
    final String lista = json.encode(listaTarefas);//converte a listaTarefas em um texto no padrao Json
    _prefs.setString('lista_tarefas', lista);//armazena no shared preferences a lista de tarefas
  }

}