import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test/app/_shared/settings/cubit/settings_cubit.dart';
import 'package:app_test/app/_shared/widgets/loading.dart';
import 'package:app_test/app/features/auth/domain/entities/user.dart';
import 'package:app_test/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_test/app/features/tasks/widgets/textfield.dart';
import 'package:app_test/app/features/tasks/widgets/toast.dart';
import 'package:app_test/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthCubit authCubit;
  late SettingsCubit settingsCubit;
  final loginForm = FormGroup({
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'password': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  @override
  void initState() {
    super.initState();
    authCubit = context.read<AuthCubit>();
    settingsCubit = context.read<SettingsCubit>();
  }

  _authListener(BuildContext context, AuthState state) {
    if (state is AuthError) {
      Toast.show(
        context,
        state.message,
        color: Theme.of(context).colorScheme.error,
      );
    }
  }

  _selectLanguage() {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(S.current.english),
              onTap: () {
                settingsCubit.setLocale('en');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(S.current.spanish),
              onTap: () {
                settingsCubit.setLocale('es');
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: [
              IconButton(
                onPressed: _selectLanguage,
                icon: const Icon(Icons.language),
              ),
              IconButton(
                onPressed: () {
                  settingsCubit.setDarkMode(!settingsState.cache.isDarkMode);
                },
                icon: Icon(!settingsState.cache.isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode),
              ),
            ],
          ),
          body: BlocListener<AuthCubit, AuthState>(
            listener: _authListener,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return ReactiveForm(
                  formGroup: loginForm,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.current.login,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    S.current.loginDescription,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.grey[700],
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    formControlName: 'email',
                                    hintText: S.current.email,
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    formControlName: 'password',
                                    hintText: S.current.password,
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (loginForm.valid) {
                                          authCubit.login(
                                            user: User(
                                              email: loginForm
                                                  .control('email')
                                                  .value,
                                              password: loginForm
                                                  .control('password')
                                                  .value,
                                            ),
                                          );
                                        } else {
                                          for (final control
                                              in loginForm.controls.entries) {
                                            control.value.markAsDirty();
                                          }
                                          Toast.show(
                                            context,
                                            S.current.pleaseFillFields,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                          );
                                        }
                                      },
                                      child: Text(
                                        S.current.login,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.current.dontHaveAccount,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Colors.grey[700],
                                            ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/register');
                                        },
                                        child: Text(
                                          S.current.signUp,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state is AuthLoading) LoadingWidget()
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
