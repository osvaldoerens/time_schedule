import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testmobile_flutter/main.dart';
import 'package:testmobile_flutter/sql_helper.dart';
import 'package:testmobile_flutter/test1/onboard/onboard_screen.dart';
import 'package:testmobile_flutter/test2/form_list_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();

}

class _NoteListScreenState extends State<NoteListScreen> {

  List dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    _queryAllRows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Catatan'),
      centerTitle: true,
      actions: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('LOGOUT !!!', textAlign: TextAlign.center,),
                      content: const Text('Apakah Anda ingin keluar'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Tidak'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          const OnBoardScreen()), (Route<dynamic> route) => false),
                          child: const Text('Keluar'),
                        ),
                      ],
                    )
                );
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormListScreen(),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, size: 30, color: Colors.blueGrey),
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(15),
        ),
       child: ListView.builder(
         itemCount: dataList.length,
         itemBuilder: (BuildContext context, int index) {
           var note = dataList[index];
           return Card(
             child: ListTile(
               leading: const Icon(Icons.album),
               title: Text('${note['judul']}', style: const TextStyle(color: Colors.black),),
               subtitle: Text('${note['deskripsi']}', style: const TextStyle(color: Colors.black)),
             ),
           );
         },
       ),
      )
    );
  }

  void _queryAllRows() async {
    final result = await dbHelper.queryAllRows(table: SQLHelper.tableList);
    debugPrint('result : ${result.toString()}');
    setState(() {
      dataList = result;
    });
  }
}
