import 'package:flutter_test/flutter_test.dart';
import '../example/lib/flutter_vibrate.dart';
import 'package:flutter_vibrate/flutter_vibrate_platform_interface.dart';
import 'package:flutter_vibrate/flutter_vibrate_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterVibratePlatform
    with MockPlatformInterfaceMixin
    implements FlutterVibratePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterVibratePlatform initialPlatform = FlutterVibratePlatform.instance;

  test('$MethodChannelFlutterVibrate is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterVibrate>());
  });

  test('getPlatformVersion', () async {
    FlutterVibrate flutterVibratePlugin = FlutterVibrate();
    MockFlutterVibratePlatform fakePlatform = MockFlutterVibratePlatform();
    FlutterVibratePlatform.instance = fakePlatform;

    expect(await flutterVibratePlugin.getPlatformVersion(), '42');
  });
}
