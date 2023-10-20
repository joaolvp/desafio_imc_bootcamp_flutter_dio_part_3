import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> lista = [];
  obterBox() async {
    // Obtém a lista de dados
    final box = await Hive.openBox<String>('dados');
    lista = box.values.toList();

    // Imprime a lista de dados
    print('DADOS SÃO:');
    print(lista);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('atualizou');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: FutureBuilder(
        future: obterBox(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index){
                return Center(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(lista[index], style: TextStyle(fontSize: 20, color: lista[index].split('=>')[1].toString().trim() == 'Saudável' ? Colors.green : Colors.red),)));
              } );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
      }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/calcularimc');
          }),
    );
  }

}
