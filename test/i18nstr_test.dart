import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i18nstr/i18nstr.dart';

void main() {
  const MethodChannel channel = MethodChannel('i18nstr');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
   // expect(await I18nstr.platformVersion, '42');
  });
}
