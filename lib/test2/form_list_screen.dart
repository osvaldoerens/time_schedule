import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:testmobile_flutter/main.dart';
import 'package:testmobile_flutter/sql_helper.dart';

class FormListScreen extends StatefulWidget {
  const FormListScreen({Key? key}) : super(key: key);

  @override
  State<FormListScreen> createState() => _FormListScreenState();
}

class _FormListScreenState extends State<FormListScreen> {
  TextEditingController judul = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController wktuPengingat = TextEditingController();
  TextEditingController wktuIntvl = TextEditingController();
  TextEditingController lampiran = TextEditingController();

  late String titleText;
  late String descriptionText;
  bool isReadOnly = false;
  bool isSwitched = false;
  DateTime? _dateTime;
  final ImagePicker _picker = ImagePicker();
  Uint8List? fileImageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Catatan'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15
        ),
        child: ListView(
          children: [
            TextFormField(
              controller: judul,
              decoration: const InputDecoration(
                // border: InputBorder.none,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.black)
                ),
                hintText: 'Judul Catatan',
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
              ),
                style:  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,
              ),
              onChanged: (value) {
                titleText = value;
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              maxLines: null,
              controller: deskripsi,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                // border: InputBorder.none,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.black)
                ),
                hintText: 'Masukan Deskripsi',
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style:  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              onChanged: (value) {
                titleText = value;
              },
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    enabled: isSwitched,
                      controller: wktuPengingat,
                      readOnly: true,
                      decoration: const InputDecoration(
                        // border: InputBorder.none,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        hintText: 'Waktu Pengingat',
                        hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
                      ),
                      style:  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
                      onTap: (){
                          if(isSwitched  == true) {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2099),
                            ).then((date) { //tambahkan setState dan panggil variabel _dateTime.
                              setState(() {
                                _dateTime = date;
                                wktuPengingat.text =  DateFormat("dd/MM/yyyy").format(_dateTime!);
                              });
                            });
                          }
                      },
                  ),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value){
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeColor: Colors.green,
                  activeTrackColor: const Color(0xFF227C70),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            TextFormField(
            enabled: isSwitched,
              decoration: const InputDecoration(
                // border: InputBorder.none,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.black)
                ),
                hintText: 'Masukan Jarak Waktu',
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style:  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              onChanged: (value) {
                setState( () {
                    if(isSwitched == true){
                      //
                    }
                  }
                );
              },
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    onChanged: (value){
                      setState(() {
                      });
                    },
                      readOnly: true,
                      controller: lampiran,
                      decoration: const InputDecoration(
                        filled: true,
                        // fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(color: Colors.black, width: 2)
                        ),
                        hintText: 'Unduh File',
                        hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      style: const TextStyle(fontSize: 16.0)
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.upload_file,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: const Text('Pilih File', style: TextStyle(fontSize: 16.0)),
                  onPressed: () {
                    // selectFile();
                    getImageFromGallery();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF227C70),
                    minimumSize: const Size(122, 48),
                    maximumSize: const Size(122, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: () {
                _insert();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                backgroundColor: Colors.white,
              ),
              child: const Text('Simpan Catatan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      SQLHelper.judul: judul.value.text,
      SQLHelper.deskripsi: deskripsi.value.text,
      SQLHelper.remindTime: wktuPengingat.value.text,
      SQLHelper.intrvTime: wktuIntvl.value.text,
      SQLHelper.lampiran: fileImageBytes

    };

    await dbHelper.insert(row,table: SQLHelper.tableList).then((value){
      debugPrint('inserted row id: $value');
      Navigator.pop(context);

    }).catchError((onError){
      const snackBar = SnackBar(content: Text('Gagal Input Catatan'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  getImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source:ImageSource.gallery
    );


    if(pickedFile != null){
      String fileName = pickedFile.path.split('/').last;
      await pickedFile.readAsBytes().then((value){
        setState(() {
          lampiran.text = fileName;
          fileImageBytes = value;
        });
      });
    }
  }
}