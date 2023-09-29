import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final dio = Dio();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> authenticate(
      {required String email, required String password}) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    try {
      // Define the request headers
      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
      };

      // Define the request body
      Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };
      final response = await dio.post(
        'http://108.61.103.32:8080/auth/api/v1/sign-in',
        data: data,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        setState(() {
          errorMessage = '';
        });
      }
      print(response.data);
    } on DioException catch (error) {
      print(error);
      setState(() {
        errorMessage = 'Sorry, unrecognized username or password.';
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Sorry, failed to login. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'http://www.sitebuilder.pk/sites/default/files/1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) {
              if (emailFocusNode.hasFocus) {
                emailFocusNode.unfocus();
              }
              if (passwordFocusNode.hasFocus) {
                passwordFocusNode.unfocus();
              }
            },
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A5073).withOpacity(.2),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    color: Colors.black.withOpacity(.7),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'Times New Roman',
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 26),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 13),
                                child: Icon(
                                  Icons.mail_outlined,
                                  color: Colors.white60,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    // alignLabelWithHint: true,
                                    // prefixIcon: Icon(
                                    //   Icons.mail_outlined,
                                    //   color: Colors.white60,
                                    // ),
                                    // prefixIconConstraints: BoxConstraints(
                                    //   minWidth: 40,
                                    //   maxHeight: 5,
                                    // ),
                                    labelText: 'E-mail',
                                    labelStyle: const TextStyle(
                                      color: Colors.white60,
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 18,
                                      height: .4,
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      ),
                                    ),
                                    errorStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF8C2E0B),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'E-mail field is required.';
                                    } else if (!value.contains('@') ||
                                        !value.contains('.')) {
                                      return 'Not valid e-mail.';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  focusNode: emailFocusNode,
                                  controller: emailController,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocusNode);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 13),
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white60,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    // alignLabelWithHint: true,
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(
                                      color: Colors.white60,
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 18,
                                      height: .4,
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      ),
                                    ),
                                    errorStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF8C2E0B),
                                    ),
                                  ),
                                  obscureText: true,
                                  focusNode: passwordFocusNode,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password field is required.';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (_) async =>
                                      await authenticate(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              'Forgot your password?',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          // const SizedBox(height: 20),
                          if (errorMessage.isNotEmpty)
                            Container(
                              width: MediaQuery.of(context).size.width * .8,
                              margin: const EdgeInsets.only(
                                left: 35,
                                right: 5,
                                top: 20,
                              ),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF5F1),
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xFFED541D),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    errorMessage,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF8C2E0B),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Have you forgotten your password?',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: ElevatedButton(
                              onPressed: () async => await authenticate(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
