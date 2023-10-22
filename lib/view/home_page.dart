import 'dart:developer';
import 'package:desafio_imc_bootcamp_flutter_dio_part_3/view_model/gerar_calculo_imc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> lista = [];
  String? nome;
  String? altura;
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  obterBox() async {
    final box = await Hive.openBox<String>('dados');
    lista = box.values.toList();

  }

  buscarDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    nomeController.text = prefs.getString('nome') ?? '';
    alturaController.text = prefs.getString('altura') ?? '';
  }

  @override
  void initState() {
    super.initState();
    obterBox();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        backgroundColor: const Color(0xff00cccc),
      ),
      body: FutureBuilder(
          future: buscarDados(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                padding: const EdgeInsets.all(15),
                child: Column(children: [
                  TextFormField(
                    controller: nomeController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        label: Text('Nome'), border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: alturaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text('Altura(em metros)'),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: pesoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text('Peso(em quilos)'),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async{
                            try {
                              await gerarCalculoIMC(
                                  nomeController.text,
                                  double.parse(
                                      pesoController.text.replaceAll(',', '.')),
                                  double.parse(alturaController.text
                                      .replaceAll(',', '.')),
                                  context);
                              setState(() {
                                obterBox();
                              });
                            } catch (error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Insira formatos de peso e altura válidos'),
                                backgroundColor: Colors.red,
                              ));
                              return log('$error');
                            }
                          },
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff00cccc))),
                          child: const Row(
                            children: [
                              Text('Calcular'),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.calculate)
                            ],
                          ),
                          ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: lista.length,
                        itemBuilder: (context, index) {
                          return Center(
                              child: Container(
                                decoration: BoxDecoration(border: Border.all(width: 1, color: const Color(0xff00cccc))),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    lista[index],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: lista[index]
                                                    .split('=>')[1]
                                                    .toString()
                                                    .trim() ==
                                                'Saudável'
                                            ? Colors.green
                                            : Colors.red),
                                  )));
                        }),
                  ),
                ]),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
