// importação do pacote de icones do material design
import 'package:flutter/material.dart';

import 'Models/item.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' TurismoApp',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    items.add(Item(title: "items 0", done: false));
    items.add(Item(title: "items 1", done: true));
    items.add(Item(title: "items 2", done: false));
    items.add(Item(title: "items 3", done: false));
    items.add(Item(title: "items 4", done: false));
    items.add(Item(title: "items 5", done: false));
    items.add(Item(title: "items 6", done: true));
    items.add(Item(title: "items 7", done: false));
    items.add(Item(title: "items 8", done: true));
    items.add(Item(title: "items 9", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // utliza-se Scaffold em vez de Container para retorna uma pagina
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App"),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Text(widget.items[index].title);
        },
      ),
    );
  }
}
