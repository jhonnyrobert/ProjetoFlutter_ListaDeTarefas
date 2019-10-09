// importação do pacote de icones do material design
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/item.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' TurismoApp',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

// FUNÇÃO PARA ADCIONAR ITEN A LISTA, {SE} SÓ CLIQUE NO BOTÃO ELE NÃO ADCIONA NADA
  void add() {
    if (newTaskCtrl.text.isEmpty) return;
    setState(() {
      widget.items.add(
        Item(title: newTaskCtrl.text, done: false),
      );
      newTaskCtrl.text = "";
    });
  }

// FUNÇÃO PARA REMOVER ITEN DA LISTA
  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  // FUNÇÃO PARA SALVAR A LISTA NO DISPOSITIVO

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

// se a lista não for nula ele transforma os dados da lista em um JSON
    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  _HomePageState() {
    load();
  }
  @override
  Widget build(BuildContext context) {
    // utliza-se Scaffold em vez de Container para retorna uma pagina
    return Scaffold(
      // barra superior
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            labelText: "Nova Tarefa",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),

      // metodo para construir dinamicamente a lista, baseado no tamanho dos itens
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctx, int index) {
          final item = widget.items[index];
          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value;
                });
              },
            ),
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.7),
              child: Icon(Icons.delete),
            ),
            onDismissed: (direction) {
              print(direction);
            },
          );
        },
      ),

      // botão de ação
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
