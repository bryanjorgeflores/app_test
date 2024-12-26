part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState(this.cache);
  final SettingsStateCache cache;

  @override
  List<Object> get props => [cache];
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial(super.cache);
}

class GettingDarkMode extends SettingsState {
  const GettingDarkMode(super.cache);
}

class GotDarkMode extends SettingsState {
  final bool isDarkMode;

  const GotDarkMode(super.cache, {required this.isDarkMode});
}

class ErrorGettingDarkMode extends SettingsState {
  final String message;

  const ErrorGettingDarkMode(super.cache, {required this.message});
}

class SettingDarkMode extends SettingsState {
  const SettingDarkMode(super.cache);
}

class DarkModeSaved extends SettingsState {
  final bool isDarkMode;

  const DarkModeSaved(super.cache, {required this.isDarkMode});
}

class SetDarkModeError extends SettingsState {
  final String message;

  const SetDarkModeError(super.cache, {required this.message});
}

class GettingCurrentLocale extends SettingsState {
  const GettingCurrentLocale(super.cache);
}

class GotCurrentLocale extends SettingsState {
  final String locale;

  const GotCurrentLocale(super.cache, {required this.locale});
}

class ErrorGettingCurrentLocale extends SettingsState {
  final String message;

  const ErrorGettingCurrentLocale(super.cache, {required this.message});
}

class SettingLocale extends SettingsState {
  const SettingLocale(super.cache);
}

class LocaleSaved extends SettingsState {
  final String locale;

  const LocaleSaved(super.cache, {required this.locale});
}

class SetLocaleError extends SettingsState {
  final String message;

  const SetLocaleError(super.cache, {required this.message});
}

class SettingsStateCache extends Equatable {
  final bool isDarkMode;
  final String locale;

  const SettingsStateCache({
    this.isDarkMode = false,
    this.locale = 'en',
  });

  const SettingsStateCache.initial()
      : isDarkMode = false,
        locale = 'en';

  @override
  List<Object?> get props => [isDarkMode, locale];

  SettingsStateCache copyWith({
    bool? isDarkMode,
    String? locale,
  }) {
    return SettingsStateCache(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      locale: locale ?? this.locale,
    );
  }
}
