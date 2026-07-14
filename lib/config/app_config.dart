import 'app_config_type.dart';

class AppConfig with AppConfigType {
  String? url;
  static final AppConfig shared = AppConfig._instance();

  factory AppConfig(String url) {
    shared.url = url;
    return shared;
  }

  AppConfig._instance();

  @override
  String get baseDomain => url ?? '';

  @override
  String get avatarBaseUrl => '$baseDomain/images';
}
