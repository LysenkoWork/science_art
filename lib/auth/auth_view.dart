import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_bloc.dart';
import 'auth_event.dart';
import 'auth_repository.dart';
import 'auth_state.dart';

class AuthPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
          child: Scaffold(
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  // Navigating to the dashboard screen if the user is authenticated
                  // TODO: implement listener}
//                  Navigator.pushReplacement(context,
//                      MaterialPageRoute(builder: (context) => const Dashboard()));
                }
                if (state is AuthError) {
                  // Showing the error message if the user has entered invalid credentials
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Loading) {
                    // Showing the loading indicator while the user is signing in
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is UnAuthenticated) {
                    return FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(children: [
                        FormBuilderTextField(
                          name: 'name',
                          decoration: const InputDecoration(
                            labelText: 'Имя',
                          ),
                        ),
                        FormBuilderTextField(
                          name: 'password',
                          decoration: const InputDecoration(
                            labelText: 'Пароль',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(SignInRequested(
                             _formKey.currentState!.fields['name']?.value,
                             _formKey.currentState!.fields['password']?.value));},
                          child: const Text('Войти'))
                      ]),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ));
  }
}
