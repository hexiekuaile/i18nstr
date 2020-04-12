/*import 'dart:async';

import 'package:flutter/services.dart';

class I18nstr {
  static const MethodChannel _channel =
      const MethodChannel('i18nstr');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}*/

//import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class I18nstr {
  //约定：国际化字符串必须放在这个目录下
  static const String _dir = './i18n/';
  Locale _loc;
  Map<String, dynamic> _map;

  I18nstr(Locale loc) {
    this._loc = loc;
  }

  //国际化json文件目录
  String get dir => _dir;

  //区域
  Locale get locale => _loc;

  //国际化字符串map
  Map<String, dynamic> get map => _map;

  //获取context中的Strings
  static I18nstr of(BuildContext context) {
    return Localizations.of<I18nstr>(context, I18nstr);
  }

//获取国际化字符串类
  static Future<I18nstr> load(Locale loc) async {
    String p;
    if (loc?.countryCode?.isEmpty == true)
      p = '$_dir${loc.languageCode}.json';
    else
      p = '$_dir${loc.languageCode}_${loc.countryCode}.json';
    String data = await rootBundle.loadString(p);
    I18nstr str = new I18nstr(loc);
    str._map = json.decode(data);
    return str;
  }

  String valueOf(String key, {List<dynamic> args, Map<dynamic, dynamic> namedArgs}) {
    String value;
    //1、支持嵌套功能：比如key=a.b.c
    if (key.contains('.')) {
      List<String> list = key.split('.');
      dynamic map = _map;
      for (var i = 0; i < list.length; i++) {
        if (!((map as Map).containsKey(list[i]))) return key;
        map = (map as Map)[list[i]];
        if (i < list.length - 1) {
          if (!(map is Map)) return key;
        } else if (i == list.length - 1) {
          if (map is Map)
            return key;
          else
            value = map.toString();
        }
      }
    }
    //以下json不嵌套
    //如果json文件不存在key，则返回key
    else {
      if (!_map.containsKey(key)) return key;
      value = _map[key].toString();
    }
    //2、支持替换能：
    if (args != null || namedArgs != null) value = _interpolateValue(value, args, namedArgs);

    //3、增加变量功能：正则表达式，正向肯定预查、反向肯定预查，比如用ip=127.0.0.1 替换 a=http://<<ip>>/entity/ 中的ip
    RegExp reg = new RegExp(r"(?<=<<).*?(?=>>)");
    Iterable<Match> matches = reg.allMatches(value);
    if (matches.isNotEmpty) {
      matches.forEach((Match m) {
        String s2 = valueOf(m.group(0));
        String s1 = '<<${m.group(0)}>>';
        value = value.replaceAll(s1, s2);
      });
    }

    return value;
  }

  // 支持用字符串替换 {0} {1}等等，序号从0开始;支持用Map value替换::Map key::
  String _interpolateValue(String value, List<dynamic> args, Map<dynamic, dynamic> namedArgs) {
    for (int i = 0; i < (args?.length ?? 0); i++) {
      value = value.replaceAll("{$i}", args[i].toString());
    }

    if (namedArgs?.isNotEmpty == true) {
      namedArgs.forEach((entryKey, entryValue) => value = value.replaceAll("::${entryKey.toString()}::", entryValue.toString()));
    }

    return value;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18nstr> {
  //当前区域
  Locale _loc;
  //支持的国际化语言，对应提供的国际化json字符串文件。
  //语言列表不能为空。可以动态变化。甚至也可以没有对应的语言文件存在。
  static List<Locale> _supportedLocales = [Locale('zh', 'CN'), Locale('en', 'US')];

  I18nDelegate(this._loc);
  //必须为true，否则选择语言后，界面不能被更新
  @override
  bool isSupported(Locale locale) => true;

  //系统回调方法，loca始终是安卓手机语言设置列表第0个
  @override
  Future<I18nstr> load(Locale locale) async {
    _loc = _loc ?? locale; //这句是关键，构造方法的参数优先
    I18nstr str = await I18nstr.load(_loc);

    //在语言文件中， "supportedLocales": "zh_CN,en_US,ja_JP,ru_RU"
    //建议写在主要的、默认的语言文件中，其他语言文件没有必要写或可以不写。
    //以下每打开一次语言文件，就读取、设置一次。目的也是为了保险起见。
    _setSupportedLocales(str.valueOf("supportedLocales"));
    return str;
  }

  //从语言文件中，提取并增加语言
  // 格式：参数string= "zh_CN,en_US"
  static void _setSupportedLocales(String string) {
    if (string?.isEmpty == true) return;
    List<String> str0 = string.split(',');
    Iterable<Locale> il = str0.map<Locale>((str00) {
      List<String> str000 = str00.split('_');
      return Locale(str000[0], str000[1]);
    });
    Set<Locale> set = _supportedLocales.toSet();
    set.addAll(il);
    _supportedLocales = set.toList();
  }

  //true 是改变语言的必须
  @override
  bool shouldReload(I18nDelegate old) => true;

  static List<Locale> get supportedLocales => _supportedLocales;
}
