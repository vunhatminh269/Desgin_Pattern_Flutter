import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../ViewModel/AuthViewModel.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vmLogin = Provider.of<Auth_ViewModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;
    final titleFontSize = size.width * 0.08;
    final buttonFontSize = size.width * 0.045;
    final verticalSpace = size.height * 0.02;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(padding),
            width: double.infinity,
            height: size.height - MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: verticalSpace),
                Text(
                  "Đăng Nhập",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: verticalSpace * 1.5),
                      buildTextField(
                        controller: vmLogin.emailController,
                        label: "Email",
                        pass: false,
                        validator: vmLogin.validateEmail,
                        fontSize: buttonFontSize,
                      ),
                      SizedBox(height: verticalSpace),
                      buildTextField(
                        controller: vmLogin.passwordController,
                        label: "Mật khẩu",
                        pass: true,
                        validator: vmLogin.validatePassword,
                        fontSize: buttonFontSize,
                      ),
                      SizedBox(height: verticalSpace * 0.5),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => context.push('/ForgotPassword'),
                      child: Text(
                        "Quên mật khẩu?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade600,
                          fontSize: buttonFontSize,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push('/Register'),
                      child: Text(
                        "Chưa có tài khoản?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade600,
                          fontSize: buttonFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: verticalSpace),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.push('/HomePage');
                      return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB02700),
                    padding: EdgeInsets.symmetric(vertical: verticalSpace * 0.8),
                    minimumSize: Size(size.width * 0.6, size.height * 0.06),
                  ),
                  child: Text(
                    "Đăng Nhập",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: buttonFontSize,
                    ),
                  ),
                ),
                SizedBox(height: verticalSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(color: Colors.red, indent: 2, endIndent: 8),
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade600,
                        fontSize: buttonFontSize,
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.red, indent: 8, endIndent: 2),
                    ),
                  ],
                ),
                SizedBox(height: verticalSpace),
                ElevatedButton(
                  onPressed: () {
                    // Handle Google login
                    context.push('/HomePage');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: verticalSpace * 0.8),
                    minimumSize: Size(size.width * 0.6, size.height * 0.06),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        height: size.height * 0.03,
                        width: size.height * 0.03,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Đăng Nhập bằng Google",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: buttonFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: verticalSpace),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: verticalSpace),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            "English",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: buttonFontSize,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "/",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: buttonFontSize,
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            "Tiếng Việt",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: buttonFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required bool pass,
    required String? Function(String?) validator,
    required double fontSize,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: pass ? hidePassword : false,
      validator: validator,
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: fontSize),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        suffixIcon: pass
            ? IconButton(
                icon: Icon(
                  hidePassword ? Icons.visibility_off_rounded : Icons.visibility,
                  color: Colors.black87,
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      style: TextStyle(fontSize: fontSize),
    );
  }
}
