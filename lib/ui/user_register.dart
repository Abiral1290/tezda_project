
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezda_projects/ui/login_page.dart';

import '../provider/item_provider.dart';
import '../provider/user_provider.dart';
import '../utilities/constants.dart';
import '../utilities/generate_route.dart';
import '../utilities/utilities.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Register'),
      ),
      body: Consumer<UserProvider>(builder: (context,provider,child){
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(labelText: 'Username', hintText: 'Username', prefixIcon: Icons.people,
                    controller: _usernameController, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    }),
                SizedBox(height: 10),
                CustomTextFormField(labelText: 'Email', hintText: 'Email',
                    prefixIcon: Icons.email,
                    controller: _emailController, validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    }),
               const SizedBox(height: 10),
                CustomTextFormField(labelText: 'Password', obscureText: true,hintText: 'Password',
                    prefixIcon: Icons.password,
                    controller: _passwordController, validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    }),

                const SizedBox(height: 10),
                BeautifulButton(name: "Register", onPressed:  () async {
                  if (_formKey.currentState!.validate()) {
                    provider.register(username: _usernameController.text,
                        password: _passwordController.text,
                        email: _emailController.text).then((value) {


                      if (provider.status == Status.error) {
                        Utilities.mytoast(provider.errorMessage, ToastKind.error, null);
                        return;
                      }

                      if (provider.status == Status.success) {
                        Utilities.mytoast('Logged in successfully', ToastKind.success, null);
                        Provider.of<ItemProvider>(context,listen: false).fetchItems();
                        Navigator.pushNamed(context, GeneratedRoutes.itemList);
                      }

                      // if(provider.)
                    });

                  }
                }),

              ],
            ),
          ),
        );
      },)
    );
  }
}
