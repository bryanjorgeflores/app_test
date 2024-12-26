import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app_test/app/features/auth/domain/entities/user.dart';
import 'package:app_test/app/features/auth/domain/usecases/login.dart';
import 'package:app_test/app/features/auth/domain/usecases/logout.dart';
import 'package:app_test/app/features/auth/domain/usecases/register.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login _login;
  final Register _register;
  final Logout _logout;

  AuthCubit(
    this._login,
    this._register,
    this._logout,
  ) : super(const AuthInitial(AuthStateCache.initial()));

  void getSavedUser() async {
    emit(GettingSavedUser(
      state.cache,
    ));
    final user = await _login.getSavedUser();

    user.fold(
      (failure) =>
          emit(GetSavedUserError(state.cache, message: failure.message)),
      (user) =>
          emit(GotSavedUser(state.cache.copyWith(user: user), user: user)),
    );
  }

  void login({
    required User user,
  }) async {
    emit(AuthLoading(
      state.cache,
    ));
    final result = await _login(user);

    result.fold(
      (failure) => emit(AuthError(state.cache, message: failure.message)),
      (user) => emit(AuthLoaded(state.cache.copyWith(user: user), user: user)),
    );
  }

  void register({
    required User user,
  }) async {
    emit(UserRegistering(
      state.cache,
    ));
    final result = await _register(user);

    try {
      result.fold(
        (failure) =>
            emit(UserRegisterError(state.cache, message: failure.message)),
        (user) =>
            emit(UserRegistered(state.cache.copyWith(user: user), user: user)),
      );
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    emit(AuthLoading(
      state.cache,
    ));
    final result = await _logout();

    result.fold(
      (failure) => emit(AuthError(state.cache, message: failure.message)),
      (_) => emit(AuthInitial(AuthStateCache.initial())),
    );
  }
}
