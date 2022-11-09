import 'package:dreavy/providers/user_info_provider.dart';
import 'package:dreavy/ui/login/sign_up_page.dart';
import 'package:dreavy/ui/login/validators.dart';
import 'package:dreavy/ui/shared/dreavy_button.dart';
import 'package:dreavy/ui/shared/dreavy_formfield.dart';
import 'package:dreavy/ui/shared/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key, required this.state}) : super(key: key);

  final GoRouterState state;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(text: 'moumiz@epitech.eu');
  final TextEditingController _pwdController = TextEditingController(text: 'Aa1!bb');

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context
          .read<UserInfoProvider>()
          .getUser(_emailController.text, _pwdController.text);
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
            fit: BoxFit.cover,
          ),
        ),
        child: GlassContainer(
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0, top: 32.0),
                  child: Text(
                    'Dreavy',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                DreavyFormField(
                  label: 'Email',
                  icon: Icons.person,
                  controller: _emailController,
                  validator: Validators.validateEmail,
                ),
                DreavyFormField(
                  label: 'Password',
                  icon: Icons.lock,
                  hide: true,
                  controller: _pwdController,
                  validator: Validators.validatePassword,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      textAlign: TextAlign.right,
                      'forgotten password',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 16.0),
                  child: DreavyButton(
                    onPress: () => submit(context),
                    label: 'Sign In',
                  ),
                ),
                const Expanded(child: SizedBox.square()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'New to our community ? ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                SignUpPage(state: state),
                          ),
                        ),
                        child: const Text(
                          ' Join Now',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
