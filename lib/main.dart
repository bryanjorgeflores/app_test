import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test/app/_shared/settings/cubit/settings_cubit.dart';
import 'package:app_test/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_test/app/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:app_test/app/dependency_injection/dependency_injection.dart';
import 'package:app_test/app/router/router.dart';
import 'package:app_test/generated/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late GetIt getIt;
late SettingsCubit settingsCubit;
late AuthCubit authCubit;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt = await DependencyInjection.init();

  settingsCubit = getIt<SettingsCubit>();
  settingsCubit.getDarkMode();
  settingsCubit.getCurrentLocale();

  authCubit = getIt<AuthCubit>();
  authCubit.getSavedUser();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (context) => settingsCubit,
        ),
        BlocProvider<AuthCubit>(
          create: (context) => authCubit,
        ),
        BlocProvider<TasksCubit>(
          create: (context) => getIt<TasksCubit>(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xffF26E56),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark,
                seedColor: const Color(0xffF26E56),
              ),
            ),
            themeMode:
                state.cache.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            title: 'Test App',
            initialRoute: '/',
            onGenerateRoute: AppRouter.generateRoute,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(state.cache.locale),
          );
        },
      ),
    );
  }
}
