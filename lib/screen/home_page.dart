import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {

 HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box? box;
  @override
  void initState() {
    box = Hive.box('products');
    super.initState();
  }
  TextEditingController _countryController = TextEditingController();
  TextEditingController _updateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

           body: Container(

             child: Column(
               children: [
                 TextField(
                   controller: _countryController,
                 ),
                 MaterialButton(onPressed: (){
                   final userData = _countryController.text;
                   box!.add(userData);
                 },child: Text('Add'),),
                 Expanded(child: ValueListenableBuilder(valueListenable: Hive.box('products').listenable(), builder: (context,box,widget){
                   return
                     ListView.builder(

                       itemCount: box!.keys.toList().length,
                       itemBuilder: (context, index) => ListTile(
                         title: Text(box!.getAt(index).toString()),
                         trailing: Container(
                           width: 100,
                           child: Row(
                             children: [
                               IconButton(onPressed: (){
                                 box.deleteAt(index);
                               }, icon: Icon(Icons.remove)),
                               IconButton(onPressed: (){
                                 showDialog(context: context, builder: (context) => AlertDialog(title: Column(children: [
                                   TextField(controller: _updateController,),
                                   MaterialButton(onPressed: (){
                                   box.putAt(index, _updateController.text);
                                   setState(() {
                                     _updateController.clear();
                                   });
                                   Navigator.pop(context);
                                   },child: Text("update"),)
                                 ],),),);

                               }, icon: Icon(Icons.edit)),


                             ],
                           ),
                         ),
                       ),);
                 }))

               ],
             ),
           ),
      ),
    );
  }
}
