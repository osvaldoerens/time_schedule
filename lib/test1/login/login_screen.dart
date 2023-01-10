import 'package:flutter/material.dart';
import 'package:testmobile_flutter/home_screen.dart';
import 'package:testmobile_flutter/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isObsecurePass = true;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          const Padding(
            padding:  EdgeInsets.only(top: 10),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.people_alt_outlined, size: 100, color: Color(0xFF227C70),),
              ),
            ),
          ),
          const Flexible(child: Text(' Silahkan Login  ', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              showCursor: true,
              controller: username,
              cursorColor: Colors.black,
              // controller: presenter.nameController,
              decoration: const InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(),
                // border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.black)
                ),
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                cursorColor: Colors.black,
                obscureText: isObsecurePass,
                controller: password,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: const OutlineInputBorder(),
                  // border: InputBorder.none,
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        if(isObsecurePass){
                          isObsecurePass = false;
                        } else {
                          isObsecurePass = true;
                        }
                      });
                    },
                    icon: Icon(isObsecurePass == true ? Icons.remove_red_eye : Icons.password),
                  ),
                ),
              )
          ),
          const SizedBox(height: 20.0,),
          InkWell(
            onTap: ()  {
              setState(() {
                doLogin(email: username.value.text, password: password.value.text);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              margin:const EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFF227C70),
              ),
              child : const Text("Login", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }

  void doLogin({required String email, required String password}) async {
    // select query
    final result = await dbHelper.queryLogin(email: email,password: password);
    debugPrint('query login result : ${result.toString()}');

    if(result.isNotEmpty){
        final snackBar = SnackBar(content: Text('Selamat Datang : ${result.first['namaDepan']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            HomeScreen(dataLogin: result.first,)), (Route<dynamic> route) => false);
    }
    else {
        const snackBar = SnackBar(content: Text('Silahkan periksa kembali username dan password !!!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }
}
