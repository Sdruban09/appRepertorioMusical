import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/db/nota.dart';
import 'package:notes_app/provider/notas_provider.dart';
import 'package:provider/provider.dart';

class ListaNotas extends StatelessWidget {
  final int position;
  const ListaNotas(this.position, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notasProvider = Provider.of<NotasProvider>(context);
    final notas = notasProvider.getNotasByTab(position);
    return Scaffold(
      body: ListView.builder(
        itemCount: notas.length,
        itemBuilder: (context, index) {
          final nota = notas[index];
          return InkWell(
            onLongPress: () async {
              await showDialog<Nota>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Borrar'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: double.infinity),
                      Text(
                        nota.titulo,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 8),
                      Text(nota.contenido),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text(
                        'Borrar',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        notasProvider.deleteCancion(nota);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            child: ListTile(
              title: Text(nota!.titulo),
              subtitle: Text(nota.contenido),
            ),
          );
        },
      ),
      floatingActionButton: (position == 1)
          ? FloatingActionButton(
              onPressed: () {
                notasProvider.shuffleList();
              },
              child: const Icon(
                Icons.shuffle,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
