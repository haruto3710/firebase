import 'package:firebase2/main.dart'; //firebase2は自身のFlutterのプロジェクト名
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//サインインページ
class SingInPage extends StatelessWidget {
  SingInPage(this.user);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SingIn')),
      body: Center(
          child: Column(children: [
        Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'メールアドレス:${user.email}',
              style: TextStyle(fontSize: 20),
            )),
        Center(
          child: ElevatedButton(
              child: Text('logout'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              }),
        )
      ])),
    );
  }
}
