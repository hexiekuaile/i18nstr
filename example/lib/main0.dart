import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i18nstr/i18nstr.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  I18nDelegate i18nDelegate;
  I18nstr str;
  //String _platformVersion = 'Unknown';
  @override
  void initState() {
    super.initState();
    //i18nDelegate = new I18nDelegate(Locale('zh', 'CN'));
    i18nDelegate = new I18nDelegate(null);
    //initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  /* Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await I18nstr.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    print('i18nDelegate ${i18nDelegate ?? 'i18nDelegate=null'} ');
    return MaterialApp(
      supportedLocales: I18nDelegate.supportedLocales,
      //修改i18nDelegate变量、setState，可以更改UI语言文字
      localizationsDelegates: [
        i18nDelegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          //child: Text('Running on: $_platformVersion\n'),
          child: Text('${I18nstr.of(context).valueOf('firstPage')}'),
          //child: Text('yyyy'),
        ),
      ),
    );
  }
}
