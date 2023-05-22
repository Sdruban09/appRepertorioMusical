import 'package:hive_flutter/hive_flutter.dart';

part 'nota.g.dart';

@HiveType(typeId: 0)
class Nota extends HiveObject {
  @HiveField(0)
  final String titulo;

  @HiveField(1)
  final String contenido;

  @HiveField(2)
  final int idTab;

  Nota(
    this.titulo,
    this.contenido,
    this.idTab,
  );
}
