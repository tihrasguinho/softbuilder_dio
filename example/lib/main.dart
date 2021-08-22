import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:softbuilder_dio/softbuilder_dio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton(DioCustom(baseUrl: 'http://192.168.100.23:3000/'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = GetIt.I.get<DioCustom>();

  final load = ValueNotifier<bool>(false);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final name = TextEditingController();
  late final email = TextEditingController();
  late final password = TextEditingController();

  void changeLoad() => load.value = !load.value;

  signUp(context) async {
    changeLoad();

    try {
      var res = await dio.post(
        '/auth/signup',
        data: jsonEncode(
          {
            'name': name.text,
            'email': email.text,
            'password': password.text,
          },
        ),
      );

      print(res.data);

      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Center(
            child: Text('signed up!'),
          ),
        ),
      );

      changeLoad();
    } on DioError catch (e) {
      changeLoad();

      print(e);

      var data = jsonDecode(e.response!.data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${data['message']}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: name,
          ),
          TextField(
            controller: email,
          ),
          TextField(
            controller: password,
          ),
          AnimatedBuilder(
            animation: load,
            builder: (_, __) => TextButton(
              onPressed: () => signUp(context),
              child: SizedBox(
                height: 52,
                width: 200,
                child: Center(
                  child: load.value
                      ? CircularProgressIndicator()
                      : Text('Sign up!'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
