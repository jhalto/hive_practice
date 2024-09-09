import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_practice/screen/home_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await hiveInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
Future<void>hiveInitialized()async{
  await Hive.initFlutter();

  Box box = await Hive.openBox('products');
  box.put('name', 'shirt');
  print('${box.get('name',)}');

}