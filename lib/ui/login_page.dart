import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:provider/provider.dart';
import 'package:tezda_projects/provider/item_provider.dart';
import 'package:tezda_projects/provider/user_login_provider.dart';
import 'package:tezda_projects/utilities/generate_route.dart';

import '../provider/user_provider.dart';
import '../utilities/constants.dart';
import '../utilities/utilities.dart';


class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
          title: Text('Login'),
        ),
        body: Consumer<UserLoginProvider>(builder: (context,provider,child){
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(labelText: 'Email', hintText: "Email",
                      prefixIcon: Icons.email,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },controller: _emailController,),
                  const SizedBox(height: 10),
                  CustomTextFormField(labelText: 'Password', hintText: "Password",
                    prefixIcon: Icons.email,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },controller: _passwordController,),

                  SizedBox(height: 20),


                  BeautifulButton(onPressed:() async {
                    if (_formKey.currentState!.validate()) {
                      provider.login(
                          password: _passwordController.text,
                          email: _emailController.text).then((value) async {

                        // if(mounted) return;
                        if (provider.status == Status.error) {
                          Utilities.mytoast(provider.errorMessage, ToastKind.error, null);
                          return;
                        }

                        if (provider.status == Status.success) {
                          Utilities.mytoast('You are registered sucessfully, Please login with given credentials',
                              ToastKind.success, null);
                          Provider.of<ItemProvider>(context,listen: false).fetchItems();
                          Navigator.pushNamed(context, GeneratedRoutes.itemList);
                        }


                        // if(provider.)
                      });
                    }
                  },name: "Login",),
                  BeautifulButton(onPressed:() async {
                    Navigator.pushNamed(context, GeneratedRoutes.registerPage);
                  },name: "Register",)
                ],
              ),
            ),
          );
        },)
    );
  }
}


class BeautifulButton extends StatelessWidget {

  final String name;
  final VoidCallback onPressed;
  const BeautifulButton({super.key,  required this.name,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return

      Center(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ).copyWith(
            elevation: ButtonStyleButton.allOrNull(0.0),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              // if (states.contains(MaterialState.pressed)) {
              //   return GradientColors.seaBlue;
              // }
              return null;
            }),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: GradientColors.seaBlue,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 200.0,
                minHeight: 50.0,
              ),
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      )
    ;
  }
}


class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final  String? Function(String?)?  validator;

  CustomTextFormField({
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}