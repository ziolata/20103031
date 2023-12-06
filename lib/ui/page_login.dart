import 'package:flutter/material.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/page_forgot.dart';
import 'package:connection/ui/page_register.dart';
import 'package:provider/provider.dart';
import '../providers/loginviewmodel.dart';
import 'custom_control.dart';
import 'page_main.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  static String routename = '/login';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;

    if (viewmodel.status == 3) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.popAndPushNamed(context, PageMain.routename);
        },
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppLogo(),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "I miss you!",
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        hintText: "username",
                        textController: _emailController,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      CustomTextField(
                        hintText: "password",
                        textController: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      viewmodel.status == 2
                          ? Text(
                              viewmodel.errorMessage,
                              style: const TextStyle(color: Colors.red),
                            )
                          : const Text(" "),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          String username = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          viewmodel.login(username, password);
                        },
                        child: const CustomButton(
                          textButton: "Đăng Nhập",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have Account?"),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .popAndPushNamed(PageRegister.routename),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple[300]),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .popAndPushNamed(PageForgot.routename),
                        child: Text(
                          ">> forgot password <<",
                          style: AppConstant.textlink,
                        ),
                      )
                    ],
                  ),
                ),
                viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
