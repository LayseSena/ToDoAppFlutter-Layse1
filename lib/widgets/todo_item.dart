import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: Icon(
            // Checkbox: Ícone de marcação
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: const Color.fromARGB(255, 97, 35, 4), // Cor do Checkbox
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Container(
            // Lixeira: Container (Botão de Excluir)
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 45, // Tamanho maior
            width: 45,  // Tamanho maior
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 202, 28, 5), // Cor do Botão
              borderRadius: BorderRadius.circular(50), // Redondo
            ),
            child: Transform.translate(
              // Move o ícone 2.0 pixels para cima
              offset: const Offset(0.0, -2.0),
              child: IconButton(
                color: Colors.white,
                iconSize: 22, // Tamanho do ícone
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onDeleteItem(todo.id);
                },
              ),
            ),
          ),
        )
    );
  }
}