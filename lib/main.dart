import 'package:desafio_imc_bootcamp_flutter_dio_part_3/view/calcular_imc.dart';
import 'package:desafio_imc_bootcamp_flutter_dio_part_3/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (_) => HomePage(),
      '/calcularimc': (_) => CalcularIMCPage(),
    },
  ));
}

