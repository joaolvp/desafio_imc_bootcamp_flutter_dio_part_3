import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/imc.dart';

armazenarDados(String nome, double peso, double altura, double imc, String imcTipo)async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getString('nome') == null || prefs.getString('nome') != nome){
    prefs.setString('nome', nome);
  }
  if(prefs.getString('altura') == null || prefs.getString('altura') != altura.toString()){
    prefs.setString('altura', altura.toString());
  }

  final box = await Hive.openBox<String>('dados');
  box.add('$nome: $peso / ($altura)² = ${imc.toStringAsFixed(2)} => $imcTipo');
  
  //prefs.remove('nome');
  //prefs.remove('altura');
  /* List<String> items = prefs.getStringList('items') ?? [];
  items.addAll(['$nome: $peso / ($altura)² = ${imc.toStringAsFixed(2)} => $imcTipo']);
  await prefs.setStringList('items', items); */

}


gerarCalculoIMC(String nome,double peso, double altura, BuildContext context)async{
  
  var dados = DadosIMC(peso, altura);
  var imc = dados.calcular();
  switch (imc) {
  case < 16:
    armazenarDados(nome, peso, altura, imc, 'Magreza grave');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Magreza grave', style: TextStyle(color: Colors.red),)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seu IMC é de ${imc.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  case  >= 16 &&  < 17:
  armazenarDados(nome, peso, altura, imc, 'Magreza moderada');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Magreza moderada', style: TextStyle(color: Colors.red),)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seu IMC é de ${imc.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  case  >= 17 &&  < 18.5:
  armazenarDados(nome, peso, altura, imc, 'Magreza leve');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Magreza leve', style: TextStyle(color: Colors.red),)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seu IMC é de ${imc.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  case >= 18.5 && < 25:
  armazenarDados(nome, peso, altura, imc, 'Saudável');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Saudável', style: TextStyle(color: Color(0xff008B8B)),)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seu IMC é de ${imc.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  case >= 25 && < 30:
  armazenarDados(nome, peso, altura, imc, 'Sobrepeso');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Sobrepeso', style: TextStyle(color: Colors.red),)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seu IMC é de ${imc.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  case >= 30 && < 35:
  armazenarDados(nome, peso, altura, imc, 'Obesidade Grau I');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Obesidade Grau I', style: TextStyle(color: Colors.red),)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seu IMC é de ${imc.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  case >= 35 && < 40:
  armazenarDados(nome, peso, altura, imc, 'Obesidade Grau II (severa)');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Obesidade Grau II (severa)', style: TextStyle(color: Colors.red),)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seu IMC é de ${imc.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  case >= 40:
  armazenarDados(nome, peso, altura, imc, 'Obesidade Grau III (mórbida)');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Obesidade Grau III (mórbida)', style: TextStyle(color: Colors.red),)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Seu IMC é de ${imc.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
}

}