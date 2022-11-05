import 'package:dreavy/providers/user_info_provider.dart';
import 'package:dreavy/ui/shared/dreavy_button.dart';
import 'package:dreavy/ui/shared/dreavy_formfield.dart';
import 'package:dreavy/ui/shared/glass_container.dart';
import 'package:dreavy/ui/login/sign_in_page.dart';
import 'package:dreavy/ui/login/validators.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final GoRouterState state;
  final _formKey = GlobalKey<FormState>();
  final _pseudoController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  SignUpPage({Key? key, required this.state}) : super(key: key);

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<UserInfoProvider>().addUser(
          _emailController.text, _pwdController.text, _pseudoController.text);
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
                      label: 'Pseudo',
                      icon: Icons.person,
                      controller: _pseudoController,
                      validator: Validators.validatePseudo),
                  DreavyFormField(
                      label: 'Email',
                      icon: Icons.mail,
                      controller: _emailController,
                      validator: Validators.validateEmail),
                  DreavyFormField(
                      label: 'Password',
                      icon: Icons.lock,
                      hide: true,
                      controller: _pwdController,
                      validator: Validators.validatePassword),
                  Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 16.0),
                      child: DreavyButton(
                          onPress: () => submit(context), label: 'Sign Up')),
                  const Expanded(child: SizedBox.square()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already with us ? ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.0)),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SignInPage(state: state),
                            ),
                          ),
                          child: const Text(' Login now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
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
