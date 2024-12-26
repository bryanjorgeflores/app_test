import 'package:flutter/material.dart';
import 'package:app_test/app/_shared/widgets/loading.dart';
import 'package:app_test/app/features/auth/domain/entities/user.dart';
import 'package:app_test/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_test/app/features/tasks/widgets/textfield.dart';
import 'package:app_test/app/features/tasks/widgets/toast.dart';
import 'package:app_test/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late AuthCubit authCubit;
  final registerForm = FormGroup({
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
  }

  _authListener(BuildContext context, AuthState state) {
    if (state is UserRegisterError) {
      Toast.show(
        context,
        state.message,
        color: Theme.of(context).colorScheme.error,
      );
    }

    if (state is UserRegistered) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: _authListener,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                ReactiveForm(
                  formGroup: registerForm,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current.createAnAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                S.current.createAccountDescription,
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
                                    if (registerForm.valid) {
                                      authCubit.register(
                                        user: User(
                                          email: registerForm
                                              .control('email')
                                              .value,
                                          password: registerForm
                                              .control('password')
                                              .value,
                                        ),
                                      );
                                    } else {
                                      for (final control
                                          in registerForm.controls.entries) {
                                        control.value.markAsTouched();
                                      }
                                      Toast.show(
                                        context,
                                        S.current.pleaseFillFields,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      );
                                    }
                                  },
                                  child: Text(
                                    S.current.register,
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
                                    S.current.alreadyHaveAccount,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.grey[700],
                                        ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      S.current.login,
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
                ),
                if (state is UserRegistering) LoadingWidget()
              ],
            );
          },
        ),
      ),
    );
  }
}
