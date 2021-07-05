import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  String _userEmail = '';
  String _userUsername = '';
  String _userPassword = '';

  void _trySubmit() {
    final bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
    }
    debugPrint(_userEmail);
    debugPrint(_userUsername);
    debugPrint(_userPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // ignore: always_specify_types
                children: [
                  TextFormField(
                    key: const ValueKey<String>('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (String value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Upišite ispravnu email adresu.';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey<String>('username'),
                      decoration:
                          const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (String value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Upišite korisničko ime.(Min. 4 slova)';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _userUsername = value;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey<String>('password'),
                    decoration: const InputDecoration(labelText: 'Šifra'),
                    obscureText: true,
                    validator: (String value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Upišite minimalno 7 karaktera.';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _userPassword = value;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: _isLogin
                        ? const Text('Prijava')
                        : const Text('Registracija'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: _isLogin
                        ? const Text('Novi korisnik? Registrujte se.')
                        : const Text('Imate račun? Prijavite se.'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
