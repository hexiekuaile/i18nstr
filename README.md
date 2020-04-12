# i18nstr

一个flutter国际化插件

## 特性

可用于web、Android ，iOS未测试。

可实时读取i18n目录下的语言文件，如zh_CN.json。

约定：语言文件放在i18n文件夹下
 
 ## 开始、使用方法
 具体参看样例
 
 i18n/zh_CN.json ，在主要的、默认的语言文件中，可加入supportedLocales，其他语言文件是否添加这个，无所谓了。
 ：
 ```json
{
  "supportedLocales": "zh_CN,en_US,ja_JP",
  "chinese": "中文",
  "english": "英语",
  "title": "国际化字符串插件测试",
  "ip": "172.16.40.101:1112",
  "system": "xx系统",
  "pushedTimes": "按键 {0} - {1} 次",
  "animal": "动物: ::dog:: ::cat:: ",
  "a": {
    "firstPage": "首页"
  },
  "c": {
    "commit": "录入  ",
    "info": "信息",
    "metaInfo": "基础信息",
    "URL_saveRow": "http://<<ip>>/entity/"
  }
}
```
 
 在main.dart中：
 ```dart
//设定 初始化默认语言，
I18nDelegate _i18nDelegate = new I18nDelegate(Locale('zh', 'CN'));
//设定null，初始化语言是 手机语言设置中的支持语言列表第一个 
//或new I18nDelegate(null);
```

```dart
class MyApp extends StatefulWidge

class _MyAppState extends State<MyApp> 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: I18nDelegate.supportedLocales,
      localizationsDelegates: [
        _i18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: HomePage(this.switchLanguage),
    );
  }

//回调函数
  void switchLanguage() {
    setState(() {});
  }
```
_str = I18nstr.of(context);
不能放在上面第一个StatefulWidge中，否则寻找不到_str。
所以又建了个StatefulWidge。
```dart
class _HomePageState extends State<HomePage> {
  I18nstr _str;

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
```
 
 ![在这里插入图片描述](./example/images/1.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2hleGlla3VhaWxl,size_16,color_FFFFFF,t_70)
  
 ![在这里插入图片描述](./example/images/2.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2hleGlla3VhaWxl,size_16,color_FFFFFF,t_70)

 ![在这里插入图片描述](./example/images/3.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2hleGlla3VhaWxl,size_16,color_FFFFFF,t_70)
 
 ![在这里插入图片描述](./example/images/4.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2hleGlla3VhaWxl,size_16,color_FFFFFF,t_70)

      