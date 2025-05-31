part of 'login_bloc.dart';

enum FormStatus { initial, invalid, valid, loading, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;
  final FormStatus status;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = FormStatus.invalid,
  });

  LoginState copyWith({String? email, String? password, FormStatus? status}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
