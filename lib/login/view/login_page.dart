import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/login/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: const _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciais inválidas')),
          );
        }
        if (state.status == FormStatus.success) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmailInput(),
            const SizedBox(height: 16),
            _PasswordInput(),
            const SizedBox(height: 32),
            const _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged:
              (email) => context.read<LoginBloc>().add(EmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.email.isEmpty ? 'Campo obrigatório' : null,
          ),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged:
              (password) =>
                  context.read<LoginBloc>().add(PasswordChanged(password)),
          decoration: InputDecoration(
            labelText: 'Senha',
            errorText: state.password.isEmpty ? 'Campo obrigatório' : null,
          ),
          obscureText: true,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status == FormStatus.loading
            ? const CircularProgressIndicator()
            : ElevatedButton(
              onPressed:
                  state.email.isNotEmpty && state.password.isNotEmpty
                      ? () => context.read<LoginBloc>().add(
                        FormSubmitted(),
                      ) // Removido const
                      : null,
              child: const Text('Entrar'),
            );
      },
    );
  }
}
