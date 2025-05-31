import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<LoginState> emit) async {
    if (state.status == FormStatus.loading)
      return; // Corrigido para comparação direta

    emit(state.copyWith(status: FormStatus.loading));

    try {
      // Simular chamada à API
      await Future.delayed(const Duration(seconds: 2));

      if (state.email == 'user@email.com' && state.password == 'senha123') {
        emit(state.copyWith(status: FormStatus.success));
      } else {
        emit(state.copyWith(status: FormStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
