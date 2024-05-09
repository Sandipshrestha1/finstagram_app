// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   double? _deviceHeight, _deviceWidth;
//   final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
//   bool passwordObscured = true;
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   bool isLoading = false;
//   String? _email;
//   String? _password;
//   @override
//   Widget build(BuildContext context) {
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: _deviceWidth! * 0.05,
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _titleWidget(),
//                 _loginForm(),
//                 _loginButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _titleWidget() {
//     return const Text(
//       "Finstagram",
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 25,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }

//   Widget _loginButton() {
//     return MaterialButton(
//       onPressed: _loginUser,
//       minWidth: _deviceWidth! * 0.70,
//       height: _deviceHeight! * 0.06,
//       color: Colors.red,
//       child: const Text(
//         "Login",
//         style: TextStyle(
//             color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
//       ),
//     );
//   }

//   Widget _loginForm() {
//     return Container(
//       height: _deviceHeight! * 0.70,
//       child: Form(
//         key: _loginFormKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             _emailTextField(),
//             SizedBox(height: 40),
//             _passwordTextField(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _emailTextField() {
//     return TextFormField(
//       controller: email,
//       decoration: const InputDecoration(
//         hintText: "Email",
//         prefixIcon: Icon(
//           Icons.email,
//         ),
//       ),
//       onSaved: (_value) {
//         setState(() {
//           _email = _value;
//         });
//       },
//       validator: (_value) {
//         bool _result = _value!.contains(
//           RegExp(r"/^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$/"),
//         );

//         return _result ? null : "Please enter  a valid email";
//       },
//     );
//   }

//   Widget _passwordTextField() {
//     return TextFormField(
//       obscureText: passwordObscured,
//       controller: password,
//       //  obscureText: true, // Hide password characters
//       decoration: InputDecoration(
//         hintText: " Password",
//         prefixIcon: const Icon(Icons.lock),
//         suffixIcon: IconButton(
//           onPressed: () {
//             setState(() {
//               passwordObscured = !passwordObscured;
//             });
//           },
//           icon: Icon(
//             passwordObscured ? Icons.visibility_off : Icons.visibility,
//           ),
//         ),
//       ),

//       onSaved: (_value) {
//         setState(() {
//           _password = _value;
//         },);

//       },
//         validator:
//         (_value) => _value!.length > 6
//             ? null
//             : "Please enter a password greater than 6  characters";
//         // (_value) {
//         //   if (_value == null || _value.isEmpty) {
//         //     return "Please enter a password";
//         //   } else if (_value.length < 6) {
//         //     return "Password must be atlease 6 character long";
//         //   }
//         //   return _value;
//         // };

//     );
//   }

//   void _loginUser() {
//     print(_loginFormKey.currentState!.validate());
//     if (_loginFormKey.currentState!.validate()) {}
//   }
// }

// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool passwordObscured = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  String? _email;
  String? _password;

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleWidget(),
                _loginForm(),
                _loginButton(),
                _registerPageLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      "Finstagram",
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: _loginUser,
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.06,
      color: Colors.red,
      child: const Text(
        "Login",
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight! * 0.70,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailTextField(),
            //  SizedBox(height: 40),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(
        hintText: "Email",
        prefixIcon: Icon(
          Icons.email,
        ),
      ),
      onSaved: (_value) {
        setState(() {
          _email = _value;
        });
      },
      validator: (_value) {
        bool _result = _value!.contains(
          RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"),
        );

        return _result ? null : "Please enter a valid email";
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: passwordObscured,
      controller: password,
      decoration: InputDecoration(
        hintText: " Password",
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passwordObscured = !passwordObscured;
            });
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
          : "Please enter a password greater than 6 characters",
    );
  }

  void _loginUser() {
    print(_loginFormKey.currentState!.validate());
    //
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
    }
  }

  Widget _registerPageLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: const Text(
        "Didn't have account ?",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 15,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}
