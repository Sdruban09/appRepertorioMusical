import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/db/nota.dart';

class NotasProvider extends ChangeNotifier {
  List<Nota> cancionesAprendidas = [];
  List<Nota> cancionesPracticar = [];

  NotasProvider() {
    initList();
  }

  void initList() {
    final notasBox = Hive.box('nota');    
    final notas = notasBox.values.cast<Nota>();
    cancionesAprendidas = notas.where((element) => element.idTab == 0).toList();
    cancionesPracticar = notas.where((element) => element.idTab == 1).toList();
    notifyListeners();
  }

  void agregarCancion(Nota nota) async{
    final notasBox = Hive.box('nota');
    await notasBox.add(nota);
    final notas = notasBox.values.cast<Nota>();
    if(nota.idTab == 0) {
      cancionesAprendidas.add(nota);
    }else {
      cancionesPracticar.add(nota);
    }    
    notifyListeners();
  }

  void deleteCancion(Nota nota) async{
    final notasBox = Hive.box('nota');
    nota.delete();
    final notas = notasBox.values.cast<Nota>();
    cancionesAprendidas = notas.where((element) => element.idTab == 0).toList();
    cancionesPracticar = notas.where((element) => element.idTab == 1).toList();
    notifyListeners();
  }

  void shuffleList() {
    cancionesPracticar.shuffle();
    notifyListeners();
  }

  List<Nota> getNotasByTab(int index){
    return index == 0 ? cancionesAprendidas : cancionesPracticar;
  }
}