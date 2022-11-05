class Validators {
  static String? validateEmail(String? value) {
    return (value == null || value.isEmpty)
        ? 'This field is required, please enter a valid email'
        : (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(value))
            ? 'Invalid email, please enter a valid one'
            : null;
  }

  static String? validatePassword(String? value) {
    return (value == null || value.isEmpty)
        ? 'This field is required, please enter a valid password'
        : (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$')
                .hasMatch(value))
            ? 'Invalid password, check if there is at least 1 uppercase/lowercase letter, 1 number and 1 special character'
            : null;
  }

  static String? validatePseudo(String? value) {
    return (value == null || value.isEmpty)
        ? 'This field is required, please enter a valid pseudo'
        : null;
  }
}
