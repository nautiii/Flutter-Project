import 'package:dreavy/ui/shared/dreavy_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dreavy/ui/shared/dreavy_formfield.dart';
import 'package:dreavy/ui/shared/glass_container.dart';

class SignInPage extends StatelessWidget {
  final GoRouterState state;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  SignInPage({Key? key, required this.state}) : super(key: key);

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      GoRouter.of(context).go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/background.jpg'),
                fit: BoxFit.cover),
          ),
          child: GlassContainer(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 40.0, top: 32.0),
                      child: Text(
                        'Dreavy',
                        style: Theme.of(context).textTheme.headline1,
                      )),
                  DreavyFormField(
                      label: 'Email',
                      icon: Icons.person,
                      controller: emailController,
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'This field is required, please enter a valid email'
                            : (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(value))
                                ? 'Invalid email, please enter a valid one'
                                : null;
                      }),
                  DreavyFormField(
                      label: 'Password',
                      icon: Icons.lock,
                      hide: true,
                      controller: pwdController,
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'This field is required, please enter a valid password'
                            : (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$')
                                    .hasMatch(value))
                                ? 'Invalid password, check if there is at least 1 uppercase/lowercase letter, 1 number and 1 special character'
                                : null;
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        textAlign: TextAlign.right,
                        'forgotten password',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 16.0),
                      child: DreavyButton(
                          onPress: () => submit(context), label: 'Sign In')),
                  const Expanded(child: SizedBox.square()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('New to our community ? ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.0)),
                        Text(' Join Now',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
