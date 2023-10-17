import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp( const MyApp());
}

class ToDoItem {
  final String name;
  bool isDone;

  ToDoItem(this.name, this.isDone);
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  List<ToDoItem> toDos = [
    ToDoItem('Einkaufen', false),
    ToDoItem('Kochen', false),
    ToDoItem('Aufräumen', false),
    ToDoItem('Waschen', false),
  ];
  Future<void> saveToDos(List<String> toDos) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList('toDos', toDos);
}

Future<List<String>> loadToDos() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('toDos') ?? [];
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Aufgaben')),
        ),
        body: ListView.builder(
          itemCount: toDos.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: Checkbox(
                value: toDos[index].isDone,
                onChanged: (bool? value) {
                  setState(() {
                    toDos[index].isDone = value ?? false;
                  });
                },
              ),
              title: Text(
                toDos[index].name,
                style: toDos[index].isDone ? const TextStyle(decoration: TextDecoration.lineThrough) : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
