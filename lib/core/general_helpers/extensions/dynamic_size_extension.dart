import 'package:v_dash_mobile/core/general_helpers/utils/screen_size_util.dart';
import 'package:v_dash_mobile/app/themes/device_dimension/theme_device_dimension.dart';

extension DynamicSizeX on num {
  double get ds {
    double width = ScreenSizeUtil.getScreenWidth();
    double scale = width / ThemeDeviceDimension.defaultScreenWidth;
    return this * scale;
  }
}