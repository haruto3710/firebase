import 'package:firebase2/singin_page.dart'; //firebase2は自身のFlutterのプロジェクト名
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Authentication',
      home: const LoginPage(),
    );
  }
}

// ログイン前のページ
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Authentication'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'mailadress'),
              onChanged: (String value) {
                setState(() {
                  email = value;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'password'),
              onChanged: (String value) {
                setState(() {
                  password = value;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton(
              child: const Text('ユーザ登録'),
              onPressed: () async {
                // Firebaseにユーザーの登録
                try {
                  final User? user = (await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password))
                      .user;
                  if (user != null)
                    print("ユーザ登録しました ${user.email} , ${user.uid}");
                } catch (e) {
                  print(e);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton(
              child: const Text('ログイン'),
              onPressed: () async {
                //ログインを実行。ログインができればサインインページに
                try {
                  final User? user = (await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password))
                      .user;
                  if (user != null)
                    print("logged in. ${user.email} , ${user.uid}");
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return SingInPage(user!);
                    }),
                  );
                } catch (e) {
                  print('cannot log in on the website. ');
                  print(e);
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
