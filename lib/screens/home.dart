import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 222, 206, 186), // Vírgula adicionada!
    appBar: _buildAppBar(),
    body: Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: const Text(
                      // TÍTULO
                        'Lista de Tarefas', 
                      
                        textAlign: TextAlign.center, 
                        style: TextStyle(
                          fontSize: 35, // Novo Tamanho
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                   
                    for (var todo in _foundTodo.reversed) 
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteTodoItem,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 116, 54, 10),
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _todoController,
                  decoration: const InputDecoration(
                    // CORREÇÃO 3: MUDANÇA DO HINT TEXT
                    hintText: 'Adicionar nova Tarefa', 
                    border: InputBorder.none,
                  ),
                ),
              )),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _addTodoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 123, 65, 10),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(60, 60),
                    elevation: 10,
                  ),
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

void _handleToDoChange(ToDo todo) {
  setState(() {
    todo.isDone = !todo.isDone;
  });
}

void _deleteTodoItem(String id) {
  setState(() {
    todosList.removeWhere((item) => item.id == id);
  });
}
  void _addTodoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: Color.fromARGB(255, 41, 37, 37),
            size: 30,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          )
        ],
      ),
    );
  }
}
