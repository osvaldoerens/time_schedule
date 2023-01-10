import 'package:flutter/material.dart';
import 'package:testmobile_flutter/test1/login/login_screen.dart';
import 'package:testmobile_flutter/test1/register/register_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
              },
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50,),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
              child: const Text('REGISTER ADMIN', style: TextStyle(
                fontSize: 15,
                letterSpacing: 2,
                color: Colors.black,),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50,),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
              child: const Text('LOGIN', style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
