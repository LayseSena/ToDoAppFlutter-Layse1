class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Criar uma conta no GitHub e enviar o projeto', isDone: true),
      ToDo(id: '02', todoText: 'Hospedar o site', isDone: true),
      ToDo(
        id: '03',
        todoText: 'Testar o site em diferentes dispositivos',
      ),
      ToDo(
        id: '04',
        todoText: 'Reunião com o time',
      ),
      ToDo(
        id: '05',
        todoText: 'Finalizar ajustes',
      ),
      ToDo(
        id: '06',
        todoText: 'Compartilhar o link final',
      ),
    ];
  }
}
