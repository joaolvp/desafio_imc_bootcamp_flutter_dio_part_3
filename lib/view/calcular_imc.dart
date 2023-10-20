import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_model/gerar_calculo_imc.dart';

class CalcularIMCPage extends StatefulWidget {
  const CalcularIMCPage({super.key});

  @override
  State<CalcularIMCPage> createState() => _CalcularIMCPageState();
}

class _CalcularIMCPageState extends State<CalcularIMCPage> {
  String? nome;
  String? altura;
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  buscarDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('nome'));
    print(prefs.getString('altura'));
    nomeController.text = prefs.getString('nome') ?? '';
    alturaController.text = prefs.getString('altura') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    /* if(nome != null){
      nomeController.text = nome as String;
    }else if(altura != null){
      alturaController.text = altura as String;
    } */
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
            future: buscarDados(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    TextFormField(
                      //initialValue: nome,
                      controller: nomeController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          label: Text('Nome'), border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      //initialValue: altura,
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
                        /* ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Voltar'),
                    ],
                  )),
              const SizedBox(
                width: 10,
              ), */
                        ElevatedButton(
                            onPressed: () {
                              try {
                                gerarCalculoIMC(
                                    nomeController.text,
                                    double.parse(pesoController.text
                                        .replaceAll(',', '.')),
                                    double.parse(alturaController.text
                                        .replaceAll(',', '.')),
                                    context);
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
                            child: const Row(
                              children: [
                                Text('Calcular'),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.calculate)
                              ],
                            )),
                      ],
                    ),
                  ]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),


      onWillPop: ()async{
        setState(() {
          
        });
        return true;      
      });
    
  }
}
