class AuthState {}

// initail
class AuthInitial extends AuthState {}

// Register
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

// Login
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

// Doctor Registion
class DoctorRegistionLoadingState extends AuthState {}

class DoctorRegistionSuccessState extends AuthState {}

// Error general
class AuhtErrorState extends AuthState {
  final String message;

  AuhtErrorState({required this.message});
}
