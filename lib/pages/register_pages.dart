// ignore_for_file: unused_label, unused_field
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool passwordObscured = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  String? _email, _password, _name;
  File? _image;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth! * 0.05,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleWidget(),
                _profileImageWidget(),
                _registrationForm(),
                _registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      " Finstagram",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _registerButton() {
    return MaterialButton(
      onPressed: _registerUser,
      minWidth: _deviceWidth! * 0.50,
      height: _deviceHeight! * 0.05,
      color: Colors.red,
      child: const Text(
        "Register",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _registrationForm() {
    return Container(
      height: _deviceHeight! * 0.30,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _nameTextField(),
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "email",
        prefixIcon: const Icon(
          Icons.email,
        ),
      ),
      validator: (_value) => _value!.length > 0 ? null : "Please enter a Email",
      onSaved: (_value) {
        setState(() {
          _email:
          _value;
        });
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: passwordObscured,
      controller: password,
      decoration: InputDecoration(
        hintText: " Password ",
        prefixIcon: const Icon(Icons.lock),
        suffix: IconButton(
          onPressed: () {
            setState(
              () {
                passwordObscured = !passwordObscured;
              },
            );
          },
          icon: Icon(
            passwordObscured ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
      onSaved: (_value) {
        setState(() {
          _password = _value;
        });
      },
      validator: (_value) => _value!.length > 6
          ? null
          : "Please enter a password greated than 6 characters",
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Name",
        prefixIcon: const Icon(
          Icons.book,
        ),
      ),
      validator: (_value) =>
          _value!.length > 0 ? null : "Please enter your name",
      onSaved: (_value) {
        setState(
          () {
            _name = _value;
          },
        );
      },
    );
  }

  Widget _profileImageWidget() {
    var _imageProvider = _image != null
        ? FileImage(_image!)
        : const NetworkImage("https://i.pravatar.cc/300");
    return GestureDetector(
      onTap: () {
        FilePicker.platform.pickFiles(type: FileType.image).then(
          (_result) {
            setState(
              () {
                _image = File(_result!.files.first.path!);
              },
            );
          },
        );
      },
      child: Container(
        height: _deviceHeight! * 0.15,
        width: _deviceHeight! * 0.15,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _imageProvider as ImageProvider,
            // NetworkImage("https://i.pravatar.cc/300"),
          ),
        ),
      ),
    );
  }

  void _registerUser() {
    if (_registerFormKey.currentState!.validate() && _image != null) {
      _registerFormKey.currentState!.save();
      print("Valid!");
    }
  }
}
