import 'package:flutter/material.dart';
import 'package:connection/providers/forgotviewmodel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_login.dart';
import 'package:provider/provider.dart';

class PageForgot extends StatelessWidget {
  PageForgot({super.key});
  static String routename = "/forgot";
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: viewmodel.status == 3
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/bronya_stick.gif"),
                      ),
                      Text(
                        "đã gửi yêu cầu thành công!",
                        style: AppConstant.textfancyheader2,
                      ),
                      Text(
                        "truy cap vao email va lam theo huong dan",
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewmodel.status = 0;
                              Navigator.popAndPushNamed(
                                  context, PageLogin.routename);
                            },
                            child: Text(
                              "Bấm vào đây ",
                              style: AppConstant.textlink,
                            ),
                          ),
                          Text("Để đăng nhập")
                        ],
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/fogort.png'),
                            width: 200,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          const Text("Điền email đã đăng ký !"),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            textController: _emailController,
                            hintText: "Email",
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            viewmodel.errormessage,
                            style: AppConstant.textError,
                          ),
                          GestureDetector(
                            onTap: () {
                              final email = _emailController.text.trim();
                              viewmodel.forgotPassword(email);
                            },
                            child: CustomButton(textButton: "Gửi yêu cầu "),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .popAndPushNamed(PageLogin.routename),
                            child: Text(
                              "Đăng nhập ",
                              style: AppConstant.textlink,
                            ),
                          )
                        ],
                      ),
                      viewmodel.status == 1
                          ? CustomSpinner(size: size)
                          : Container(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
