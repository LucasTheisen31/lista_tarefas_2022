import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_tarefas_2022/models/tarefa.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemListaTarefas extends StatelessWidget {
  ItemListaTarefas({Key? key, required this.tarefa, required this.delerarTarefa}) : super(key: key);

  final Tarefa tarefa;
  final Function(Tarefa) delerarTarefa;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Slidable(
         endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                delerarTarefa(tarefa);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          //espacamento dentro do container
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,//ocupar a maior largura possivel
            children: [
              Text(
                'Data: ${DateFormat('dd/MM/yyyy').format(
                    tarefa.data)} Hora: ${DateFormat('HH:mm').format(
                    tarefa.data)}',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                tarefa.titulo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
