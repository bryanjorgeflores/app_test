import 'package:app_test/app/_shared/local_config.dart';
import 'package:app_test/app/_shared/settings/cubit/settings_cubit.dart';
import 'package:app_test/app/features/auth/data/datasources/remote/auth_api_client.dart';
import 'package:app_test/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_test/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_test/app/_shared/settings/usecases/dark_mode.dart';
import 'package:app_test/app/_shared/settings/usecases/language.dart';
import 'package:app_test/app/features/auth/domain/usecases/login.dart';
import 'package:app_test/app/features/auth/domain/usecases/logout.dart';
import 'package:app_test/app/features/auth/domain/usecases/register.dart';
import 'package:app_test/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_test/app/features/tasks/data/datasources/remote/tasks_api_client.dart';
import 'package:app_test/app/features/tasks/data/datasources/tasks_datasource.dart';
import 'package:app_test/app/features/tasks/data/repositories/tasks_repository_impl.dart';
import 'package:app_test/app/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:app_test/app/features/tasks/domain/usecases/get_saved_tasks.dart';
import 'package:app_test/app/features/tasks/domain/usecases/get_tasks.dart';
import 'package:app_test/app/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:app_test/core/conectivity/helpers/dio_helper.dart';
import 'package:app_test/core/conectivity/implementations/http_client_dio.dart';
import 'package:app_test/core/conectivity/http_client.dart';

import 'package:get_it/get_it.dart';

class DependencyInjection {
  static final GetIt getIt = GetIt.instance;

  static Future<GetIt> init() async {
    final di = await _initGetIt(getIt);
    return di;
  }

  static _initGetIt(GetIt getIt) async {
    //dio
    final dioHelper = DioHelper();

    getIt.registerSingleton<Dio>(dioHelper.dio);
    getIt.registerSingleton<HttpClient>(HttpClientDio(getIt<Dio>()));

    //local config
    final appLocalConfig = AppLocalConfig(
      getIt<HttpClient>(),
    );
    await appLocalConfig.init();
    getIt.registerSingleton<AppLocalConfig>(
      appLocalConfig,
    );

    await dioHelper.init(
      baseUrl: appLocalConfig.user != null
          ? 'https://jsonplaceholder.typicode.com'
          : 'https://reqres.in/api',
      token: appLocalConfig.user?.token,
    );

    //auth
    getIt.registerSingleton<AuthApiClient>(
      AuthApiClient(getIt<HttpClient>()),
    );
    getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(getIt<AuthApiClient>()),
    );
    getIt.registerSingleton<Login>(
      Login(getIt<AuthRepository>(), getIt<AppLocalConfig>()),
    );
    getIt.registerSingleton<Register>(
      Register(getIt<AuthRepository>(), getIt<AppLocalConfig>()),
    );
    getIt.registerSingleton<Logout>(
      Logout(getIt<AppLocalConfig>()),
    );

    getIt.registerSingleton<AuthCubit>(
      AuthCubit(
        getIt<Login>(),
        getIt<Register>(),
        getIt<Logout>(),
      ),
    );

    //tasks
    getIt.registerSingleton<TasksDatasource>(
      TasksApiClient(getIt<HttpClient>()),
    );
    getIt.registerSingleton<TasksRepository>(
      TasksRepositoryImpl(getIt<TasksDatasource>()),
    );
    getIt.registerSingleton<GetTasks>(
      GetTasks(getIt<TasksRepository>()),
    );
    getIt.registerSingleton<GetSavedTasks>(
      GetSavedTasks(),
    );

    getIt.registerSingleton<TasksCubit>(
      TasksCubit(
        getIt<GetTasks>(),
        getIt<GetSavedTasks>(),
      ),
    );

    //settings
    getIt.registerSingleton<ManageDarkMode>(
      ManageDarkMode(getIt<AppLocalConfig>()),
    );
    getIt.registerSingleton<ManageLanguage>(
      ManageLanguage(getIt<AppLocalConfig>()),
    );
    getIt.registerSingleton<SettingsCubit>(
      SettingsCubit(
        getIt<ManageDarkMode>(),
        getIt<ManageLanguage>(),
      ),
    );

    return getIt;
  }
}
