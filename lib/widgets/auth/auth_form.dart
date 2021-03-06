import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submit, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submit;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  String _userEmail = '';
  String _userUsername = '';
  String _userPassword = '';
  File _userImageFile;

  // ignore: use_setters_to_change_properties
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Morate dodati sliku'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
    }
    widget.submit(
      _userEmail.trim(),
      _userPassword.trim(),
      _userUsername.trim(),
      _userImageFile,
      _isLogin,
      context,
    );
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
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: const ValueKey<String>('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (String value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Upi??ite ispravnu email adresu.';
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
                          const InputDecoration(labelText: 'Korisni??ko ime'),
                      validator: (String value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Upi??ite korisni??ko ime.(Min. 4 slova)';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _userUsername = value;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey<String>('password'),
                    decoration: const InputDecoration(labelText: '??ifra'),
                    obscureText: true,
                    validator: (String value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Upi??ite minimalno 7 karaktera.';
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
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: _isLogin
                          ? const Text('Prijava')
                          : const Text('Registracija'),
                    ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: _isLogin
                          ? const Text('Novi korisnik? Registrujte se.')
                          : const Text('Imate ra??un? Prijavite se.'),
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
