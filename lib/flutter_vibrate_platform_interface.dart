import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_vibrate_method_channel.dart';

abstract class FlutterVibratePlatform extends PlatformInterface {
  /// Constructs a FlutterVibratePlatform.
  FlutterVibratePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterVibratePlatform _instance = MethodChannelFlutterVibrate();

  /// The default instance of [FlutterVibratePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterVibrate].
  static FlutterVibratePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterVibratePlatform] when
  /// they register themselves.
  static set instance(FlutterVibratePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
