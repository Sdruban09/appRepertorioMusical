import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/db/nota.dart';
import 'package:notes_app/pages/lista_notas.dart';
import 'package:notes_app/provider/notas_provider.dart';
import 'package:provider/provider.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  final tabs = [
    const Tab(text: 'Por aprender'),
    const Tab(text: 'Aprendidas'),
  ];
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final notasProvider = Provider.of<NotasProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Canciones',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              final nota = await showDialog<Nota>(
                context: context,
                builder: (context) =>
                    _AgregarNotaDialog(index: controller?.index ?? 0),
              );
              if (nota != null) {
                notasProvider.agregarCancion(nota);
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          ListaNotas(0),
          ListaNotas(1),
        ],
      ),
    );
  }
}

class _AgregarNotaDialog extends StatefulWidget {
  final int index;
  const _AgregarNotaDialog({Key? key, required this.index}) : super(key: key);

  @override
  __AgregarNotaDialogState createState() => __AgregarNotaDialogState();
}

class __AgregarNotaDialogState extends State<_AgregarNotaDialog> {
  final _tituloController = TextEditingController();
  final _contenidoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar cancion'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _tituloController,
            decoration: const InputDecoration(hintText: 'Título'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _contenidoController,
            decoration: const InputDecoration(hintText: 'Contenido'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Guardar'),
          onPressed: () {
            final titulo = _tituloController.text;
            final contenido = _contenidoController.text;
            final nota = Nota(titulo, contenido, widget.index);
            Navigator.of(context).pop(nota);
          },
        ),
      ],
    );
  }
}
