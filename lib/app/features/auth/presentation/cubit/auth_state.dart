part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState(this.cache);
  final AuthStateCache cache;

  @override
  List<Object> get props => [cache];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.cache);
}

class AuthLoading extends AuthState {
  const AuthLoading(super.cache);
}

class AuthLoaded extends AuthState {
  final User user;

  const AuthLoaded(super.cache, {required this.user});

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(super.cache, {required this.message});
}

class UserRegistering extends AuthState {
  const UserRegistering(super.cache);
}

class UserRegistered extends AuthState {
  final User user;

  const UserRegistered(super.cache, {required this.user});
}

class UserRegisterError extends AuthState {
  final String message;

  const UserRegisterError(super.cache, {required this.message});
}

class GettingSavedUser extends AuthState {
  const GettingSavedUser(super.cache);
}

class GotSavedUser extends AuthState {
  final User user;

  const GotSavedUser(super.cache, {required this.user});
}

class GetSavedUserError extends AuthState {
  final String message;

  const GetSavedUserError(super.cache, {required this.message});
}

class AuthStateCache extends Equatable {
  final User? user;

  const AuthStateCache({
    this.user,
  });

  const AuthStateCache.initial()
      : user = null;

  @override
  List<Object?> get props => [user];

  AuthStateCache copyWith({
    User? user,
  }) {
    return AuthStateCache(
      user: user ?? this.user,
    );
  }
}
