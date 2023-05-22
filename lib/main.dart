import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/db/nota.dart';
import 'package:notes_app/pages/pagina_principal.dart';
import 'package:notes_app/provider/notas_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Nota>(NotaAdapter());
  await Hive.openBox('nota');  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotasProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.purple,
          primarySwatch: Colors.grey,
          secondaryHeaderColor: Colors.grey,
        ),
        home: const Scaffold(
          body: PaginaPrincipal(),
        ),
      ),
    );
  }
}
