import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app_test/app/_shared/settings/usecases/dark_mode.dart';
import 'package:app_test/app/_shared/settings/usecases/language.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ManageDarkMode _manageDarkMode;
  final ManageLanguage _manageLanguage;
  SettingsCubit(
    this._manageDarkMode,
    this._manageLanguage,
  ) : super(SettingsInitial(SettingsStateCache.initial()));

  void getCurrentLocale() async {
    emit(GettingCurrentLocale(
      state.cache,
    ));
    final result = await _manageLanguage();

    result.fold(
      (failure) => emit(
          ErrorGettingCurrentLocale(state.cache, message: failure.message)),
      (locale) => emit(
        GotCurrentLocale(
          state.cache.copyWith(locale: locale),
          locale: locale,
        ),
      ),
    );
  }

  void getDarkMode() async {
    emit(GettingDarkMode(
      state.cache,
    ));
    final result = await _manageDarkMode();

    result.fold(
      (failure) =>
          emit(ErrorGettingDarkMode(state.cache, message: failure.message)),
      (isDarkMode) => emit(
        GotDarkMode(
          state.cache.copyWith(isDarkMode: isDarkMode),
          isDarkMode: isDarkMode,
        ),
      ),
    );
  }

  void setDarkMode(bool isDarkMode) async {
    emit(SettingDarkMode(
      state.cache,
    ));
    final result = await _manageDarkMode.setDarkMode(isDarkMode: isDarkMode);

    result.fold(
      (failure) =>
          emit(SetDarkModeError(state.cache, message: failure.message)),
      (_) => emit(
        DarkModeSaved(
          state.cache.copyWith(isDarkMode: isDarkMode),
          isDarkMode: isDarkMode,
        ),
      ),
    );
  }

  void setLocale(String locale) async {
    emit(SettingLocale(
      state.cache,
    ));
    final result = await _manageLanguage.setLocale(locale: locale);

    result.fold(
      (failure) => emit(SetLocaleError(state.cache, message: failure.message)),
      (_) => emit(
        LocaleSaved(
          state.cache.copyWith(locale: locale),
          locale: locale,
        ),
      ),
    );
  }
}
