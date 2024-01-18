## Flutter ×　Firebase

## 1.About firebase
- Firebaseとは、Webやモバイル、アプリケーションの構築・運用を手助けする機能がある開発プラットフォームであり、あらかじめデータベースや認証、ホスティングやストレージを一元管理できるツールがそろっているためアプリ開発において面倒な作業を大幅に省略できるメリットがある。
本件では、Firebaseの機能をFlutterのwebアプリケーションで利用する手順を提供します

##
## 2. Prepare for Firebase
- Firebaseを使うためにプロジェクトの作成と、Firebaseを操作するためのコマンドラインインターフェースのFirebase CLIをインストールします。今回はdockerの環境で実行します。dockerでの環境構築ができていない人は以下のリンクから環境構築を行ってください。
(https://github.com/soethandara/plas_flutter_docker)

##
### 2.1 Creating a new project for Firebase
- Firebaseのホームページ (https://firebase.google.com/) にアクセスし"使ってみる(Get　started)"からFirebaseにログインします。
  <img width="953" alt="firebase_1" src="https://github.com/haruto3710/firebase/assets/110810180/275a9b48-cddf-4566-9f14-30a9120ea7cd">


- 次に、"プロジェクトを追加"から任意のプロジェクト名を入力してプロジェクトを作成します(初めて利用する場合は、アナリティクスの地域を選択する場所がありますが今回はそのままで大丈夫です)。
  <img width="893" alt="firebase_2" src="https://github.com/haruto3710/firebase/assets/110810180/3a11f67f-4a67-4a59-b126-d28701ae33fb">



### 2.2 Installing Firebase CLI

- VScodeを開き、dockerに接続してください。Node.jsをdockerの環境にインストールします。以下のコマンドを実行してください。
```
apt update
```
```
apt install nodejs npm
```
- 次にfirebaseのインストールをします。以下のコマンドを実行してください。
```
npm install -g firebase-tools
```

- CLI をインストールしたら、認証する必要があります。そのため次のコマンドでFirebaseにログインしてください。

```
firebase login
```
- 最後に以下のコマンドを実行してください。
```
dart pub global activate flutterfire_cli
```
以上で、firebase_CLIのインストールは完了です。
##
## 3. Flutter and Firebase integration

### 3.1 Create Project
- 任意の名前のプロジェクトを作成して,そのディレクトリに移動してください。

```
flutter create XXXXX　//XXXXXにプロジェクト名を入力
```
```
cd　XXXXX　//XXXXXにプロジェクト名を入力
```
### 3.2 firebase in VS code 
- まず、以下のコマンドを実行して、自分の作成したFirebaseのプロジェクトがあるか確認してください。
```
firebase projects:list
```

- 次に、以下のコマンドを実行してください。

```
flutter pub add firebase_core
```
pubspec.yamlにfirebase_coreが追加されていれば大丈夫です。
<img width="960" alt="VScode_1" src="https://github.com/haruto3710/firebase/assets/110810180/0aa8b5db-737a-42e8-995a-6d8ac2efdb0a">


- firebase_options.dartというファイルをlibフォルダの中に作成します。Firebaseで作成したプロジェクトを開き、アプリを追加からwebを選択します、プロジェクト名を入力して'npmを使用する'を選択してアプリを作成します。
<img width="950" alt="firebase_2_3" src="https://github.com/haruto3710/firebase/assets/110810180/3c98e4c3-345c-45f7-81cb-d713caa6e80b">


- アプリを作成したら、プロジェクトの設定を開き、マイアプリから自身で作成したアプリのapiKey~measurementIdと書かれている部分をコピーします。
  <img width="947" alt="VScode_4" src="https://github.com/haruto3710/firebase/assets/110810180/607a5d3d-3847-4ccc-bca2-07785ed1e912">


- 以下のコードに自身のapiKey~measurementIdをコピーして、firebase_options.dartに書き込んでください。

```
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );

      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      //この部分に自身のapiKey~measurementIdをコピー
      apiKey: " ",
      authDomain: " ",
      projectId: " ",
      storageBucket: " ",
      messagingSenderId: " ",
      appId: " ",
      measurementId: " ");
}

```

以上でFlutterでFirebaseを使用する準備は完了です。


  

- firebaseをFlutterで使用する際は、lib/main.dartファイルにインストールしたfirebase_coreと生成された firebase_optionsをインポートします。また、main()に以下のコードを追加します。

```
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //アプリの内容
    );
  }
}



```
以上がFirebaseをFlutterで利用する手順になります。

##
## 4. Use Firebase
- 実際にFirebaseの機能の使った例を一部紹介します。

##

### 4.1 Firebase Analytics
- まず、Firebase Analyticsを実装します。Firebase Analyticsとはアプリの使用状況とユーザー エンゲージメントについて分析できるアプリ測定ソリューションです。例えば、ボタンが何回押されたかや、そのページに何回アクセスされたかを確認できます。
本演習では何回ボタンが押されたかを回数を確認するコードを実行して確認してもらいます。

- 3の手順を実行して、flutterのプロジェクトを作成してください。
  
- Firebase Analyticsを利用するには、pubspec.yamlにfirebase_analyticsを追加する必要があります。そのため以下のコマンドを実行してください。
  
- firebase1のファイルからmain.dartをコピーして自身のFlutterのプロジェクトのmain.dartにコピーして、以下のコマンドでFlutterを実行してください。
```
flutter run -d web-server
```
- 実行すると表示されているボタンを数回押してください。FirebaseのメニューにあるRealtime Analyticsを確認すると何回ボタンが押されているかを確認できます。
<img width="950" alt="Flutter_1‗2" src="https://github.com/haruto3710/firebase/assets/110810180/a71afe02-a061-4d0e-b7ab-5d09398bca6c">






### 4.2  Firebase Authentication
- 次に、Firebase Authenticationを実装します。Firebase Authenticationを使うとユーザー認証機能をアプリで実装できるようになります。メールアドレスとパスワードでの認証以外にも、GoogleやX(旧Twitter)のアカウントを利用した、ログイン機能の実装もできます。
今回の演習では、任意のメールアドレスとパスワードを登録し、そのメールアドレスとパスワードでログインできるコードを実行してもらいます。

- Firebase AuthenticationをFlutterで実行する前にFirebaseでいくつか準備してもらうことがあります。
まず、FirebaseのメニューのAuthenticationのページを開きます。その中の、Sing-in methodの新しいプロバイダを使からメール/パスワードを選んで追加をします。以上でFirebaseの準備は完了です。
<img width="939" alt="VScode_6" src="https://github.com/haruto3710/firebase/assets/110810180/7bd7ad40-be6c-41ec-9f1d-21728cd4e6b7">


- 3の手順を実行して、flutterのプロジェクトを作成してください。
- Firebase Authenticationを利用するには、pubspec.yamlにfirebase_authを追加する必要があります。そのため以下のコマンドを実行してください。
```
flutter pub add firebase_auth
```

- firebase2のlibフォルダからmain.dartと、ingin_page.dartをコピーして、自身のFlutterのプロジェクトのlibフォルダにmain.dartとsingin_page.dartを作成してください。以下のコマンドでFlutterを実行してください。
  
```
flutter run -d web-server
```
- 実行するとメールアドレスと、パスワードを入力して登録ボタンを押してください。登録するとFirebaseのAuthenticationに自身の登録したメールアドレスが表示されています。
<img width="950" alt="VScode_5_7" src="https://github.com/haruto3710/firebase/assets/110810180/75e7c60a-46c7-46f6-b872-424cc12ee609">

- 次に、Flutterの画面に戻り先ほど登録したメールアドレスと、パスワードを入力してログインボタンを押してください。ログインができると、ログインページに移行して登録したメールアドレスが表示されます。
<img width="923" alt="VScode_8" src="https://github.com/haruto3710/firebase/assets/110810180/d8dfadf3-f7ad-4905-863d-e8e5fdb81c55">

##
## 5. Feedback
最後にこの資料を読んで、フィードバックをお願いします。

https://forms.gle/6fNbHpddBHoDEDVN8
##
