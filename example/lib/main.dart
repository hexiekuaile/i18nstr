import 'package:flutter/material.dart';
import 'package:i18nstr/i18nstr.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

I18nDelegate _i18nDelegate = new I18nDelegate(Locale('zh', 'CN'));
//或new I18nDelegate(null);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  void switchLanguage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: I18nDelegate.supportedLocales,
      //修改i18nDelegate,setState,可以更改UI语言文字
      localizationsDelegates: [
        _i18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: HomePage(this.switchLanguage),
    );
  }
}

class HomePage extends StatefulWidget {
  Function callback;
  HomePage(@required this.callback);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  I18nstr _str;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _str = I18nstr.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_str.valueOf('title')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${_str.valueOf('system')}'),
          Text('嵌套功能 a.firstPage ： ${_str.valueOf('a.firstPage')}'),
          Text('序号替换功能  按键 {0} - {1} 次, ： ${_str.valueOf('pushedTimes', args: [50, 80])}'),
          Text('map值替换功能  key,value ： ${_str.valueOf('animal', namedArgs: {'dog': '小狗', 'cat': '小猫'})}'),
          Text('变量功能 http://<<ip>>/entity/ ：${_str.valueOf('c.URL_saveRow')}'),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton.icon(
                icon: Icon(Icons.save, size: 25.0),
                //padding: EdgeInsets.all(15.0),
                label: Text('${_str.valueOf('english')}'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _i18nDelegate = new I18nDelegate(Locale('en', 'US'));
                    widget.callback();
                  });
                },
              ),
              RaisedButton.icon(
                icon: Icon(Icons.save, size: 25.0),
                //padding: EdgeInsets.all(15.0),
                label: Text('${_str.valueOf('chinese')}'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _i18nDelegate = new I18nDelegate(Locale('zh', 'CN'));
                    widget.callback();
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
