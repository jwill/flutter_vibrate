
import 'package:jni/jni.dart';
import 'package:flutter_vibrate/flutter_vibrate_jnigen.dart';

enum FeedbackType {
  success(50),
  error(500),
  warning(250),
  selection(HapticFeedbackConstants.KEYBOARD_TAP),
  impact(HapticFeedbackConstants.VIRTUAL_KEY),
  heavy(100),
  medium(40),
  light(10);

  const FeedbackType(this.duration);

  final int duration;
}

class Vibrate {
  static const Duration defaultVibrationDuration = Duration(milliseconds: 500);
  late Vibrator vibrator;
  static bool canVibrate = false;
  static bool hasVibrator = false;
  static bool legacyVibrator = false;



  void init() {
    final Context context = Context.fromReference(Jni.getCachedApplicationContext());
    vibrator = context.getSystemService$1(Context.VIBRATOR_SERVICE)!.as(Vibrator.type);
    hasVibrator = vibrator.hasVibrator();
    canVibrate = hasVibrator;   //fix later
    legacyVibrator = Build$VERSION.SDK_INT < 26;
  }

  void defaultVibration() {
    vibrateRaw(defaultVibrationDuration.inMilliseconds);
  }

  void vibrate(FeedbackType type) {
    vibrateRaw(type.duration);
  }

  // To match current api
  void feedback(FeedbackType type) {
    vibrateRaw(type.duration);
  }

  void vibrateRaw(int duration) {
    if (hasVibrator) {
      if (legacyVibrator) {
        vibrator.vibrate$3(duration);
      } else {
        vibrator.vibrate(VibrationEffect.createOneShot(duration, VibrationEffect.DEFAULT_AMPLITUDE));
      }
    }
  }
  

  // Doesn't work, should use createWaveform instead
  Future<void> vibrateWithPauses$1(Iterable<Duration> pauses) async {
    for (final Duration d in pauses) {
      vibrateRaw(defaultVibrationDuration.inMilliseconds);
      //Because the native vibration is not awaited, we need to wait for
      //the vibration to end before launching another one
      Future.delayed(defaultVibrationDuration);
      Future.delayed(d);
    }
    vibrateRaw(defaultVibrationDuration.inMilliseconds);
  }
}
