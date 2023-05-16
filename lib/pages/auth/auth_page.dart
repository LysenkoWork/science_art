import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../candidates/pages/candidates_page.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'services/auth_repository.dart';
import 'bloc/auth_state.dart';

import '/pages/dialog.dart';

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
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(120.0),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    // Navigating to the dashboard screen if the user is authenticated
                    // TODO: implement listener}
                    dialog(context, state.user.name as String, 'Вы успешно авторизовались', 'Ok');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CandidatePage(user: state.user)));
//                  Navigator.pushReplacement(context,
//                      MaterialPageRoute(builder: (context) => const Dashboard()));
                  }
                  if (state is AuthError) {
                    // Showing the error message if the user has entered invalid credentials
                    dialog(context, state.error, 'Ошибка', 'Ok');
//                  ScaffoldMessenger.of(context)
//                      .showSnackBar(SnackBar(content: Text(state.error)));
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
                              labelText: 'Логин',
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
                                context.read<AuthBloc>().add(
                                      SignUpRequested(
                                        _formKey.currentState!.fields['name']?.value,
                                        _formKey.currentState!.fields['password']?.value,
                                      ),
                                    );
                              },
                              child: const Text('Войти'))
                        ]),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
