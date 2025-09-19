import 'package:flutter/foundation.dart';

class PlatformUtils {
  static bool get isWeb => kIsWeb;
  static bool get isDesktop => !kIsWeb;
  static bool get isMobile => !kIsWeb;
  
  static bool get canUseNativeFeatures => !kIsWeb;
  static bool get canUsePdfGeneration => !kIsWeb;
  static bool get canUseFileSystem => !kIsWeb;
}