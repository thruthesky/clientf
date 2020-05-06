import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('플러터 커뮤니티 앱'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '플러터 스터디 공개 프로젝트 - 커뮤니티 앱 개발',
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
