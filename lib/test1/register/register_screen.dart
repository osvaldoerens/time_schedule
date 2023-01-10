import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:testmobile_flutter/main.dart';
import 'package:testmobile_flutter/sql_helper.dart';
import 'package:testmobile_flutter/test1/onboard/onboard_screen.dart';
import 'package:testmobile_flutter/validation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObsecurePass = true;
  TextEditingController namaDepan     = TextEditingController();
  TextEditingController namaBlkng     = TextEditingController();
  TextEditingController email         = TextEditingController();
  TextEditingController tglLahir      = TextEditingController();
  TextEditingController jenisKelamin  = TextEditingController();
  TextEditingController password      = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  final ImagePicker _picker = ImagePicker();
  Uint8List? fileImageBytes;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('AlertDialog Title'),
                      content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () =>    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnBoardScreen())),
                          child: const Text('OK'),
                        ),
                      ],
                    )
                );
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              )
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15,top: 20, right: 15),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    InkWell(
                      onTap : () {
                        getImageFromGallery();
                    },
                      child: Container(
                        width: 130,
                        height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 2,
                                color: Colors.black.withOpacity(0.1)
                              )
                            ],
                            shape: BoxShape.circle,
                            image : fileImageBytes != null ?
                              DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(
                                      fileImageBytes!
                                  )
                              ) :
                              const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2018/03/06/22/57/portrait-3204843__480.jpg'
                                  )
                              )
                          ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.blue,
                          ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              widgetTextField('Nama Depan', namaDepan, 'Vencesius', false,
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"),),
                  (value) {
                    if (!value.toString().isValidName) return "Enter valid Name";
                  }
                ),
              widgetTextField('Nama Belakang', namaBlkng, 'Osvaldo', false,
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"),),
                  (value) {
                    if (!value.toString().isValidName) return "Enter valid Name";
                  }
              ),
              widgetTextField('Email', email ,'osvaldo@gmail.com', false,
                  FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")),
                  (value) {
                    if (!value.toString().isValidEmail) return "Enter valid Name";
                  }
              ),
              widgetTextField('Tanggal Lahir', tglLahir , '1993-10-27', false,
                  FilteringTextInputFormatter.allow(RegExp(r"^\+?0[0-9]{10}$")),
                  (value) {
                    if (!value.toString().isNotNull) return "Enter valid Name";
                  },
                  isReadOnly: true
              ),
              widgetTextField('Jenis Kelamin', jenisKelamin  , 'Pria / Wanita', false,
                  FilteringTextInputFormatter.allow(RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")),
                  (value) {
                    if (!value.toString().isValidName) return "Enter valid Name";
                  }
              ),
              widgetTextField('Password', password, '**********', true,
                  FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")),
                  (value) {
                    if (!value.toString().isValidName) return "Enter valid Name";
                  }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50,),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                      child: const Text('CANCEL', style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black,),
                      ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _insert();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                       primary: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50,),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    child: const Text('SAVE', style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.white)
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetTextField(String labelText, TextEditingController controller, String placeHolder, bool isPassField,
                        TextInputFormatter formater, FormFieldValidator validator,{bool? isReadOnly}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30,),
      child: TextFormField(
        obscureText: isPassField ? isObsecurePass : false,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly:isReadOnly ?? false ,
        onTap: (){
          if(isReadOnly != null){
             if(isReadOnly == true) {
               showDatePicker(
                 context: context,
                 initialDate: DateTime.now(),
                 firstDate: DateTime(2000),
                 lastDate: DateTime(2099),

               ).then((date) { //tambahkan setState dan panggil variabel _dateTime.
                 setState(() {
                   _dateTime = date;

                   tglLahir.text =  DateFormat("dd/MM/yyyy").format(_dateTime!);
                 });
               });
             }
          }
        },
        validator: validator,
          decoration: InputDecoration(
              suffixIcon: isPassField ?
              IconButton(
                  onPressed: (){
                    setState(() {
                      isObsecurePass = !isObsecurePass;
                    });
                  },
                  icon: const Icon(Icons.remove_red_eye, color: Colors.grey,)
              ) : null,
              contentPadding: const EdgeInsets.only(bottom: 5),
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeHolder,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              )
          )
      ),
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      SQLHelper.namaDepan: namaDepan.value.text,
      SQLHelper.namaBlkng: namaBlkng.value.text,
      SQLHelper.email: email.value.text,
      SQLHelper.tglLahir: tglLahir.value.text,
      SQLHelper.jnsKelamin: jenisKelamin.value.text,
      SQLHelper.password: password.value.text,
      SQLHelper.fotoProfil:fileImageBytes

    };

    await dbHelper.insert(row,table: SQLHelper.table).then((value){
      debugPrint('inserted row id: $value');
      Navigator.pop(context);

    }).catchError((onError){
      const snackBar = SnackBar(content: Text('Gagal Input Data'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }


  getImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source:ImageSource.gallery ,
    );

    if(pickedFile != null){
      await  pickedFile.readAsBytes().then((value){
        setState(() {
          fileImageBytes = value;
        });
      });
    }
  }
}


