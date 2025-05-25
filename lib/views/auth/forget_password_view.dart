import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/forget_password_model.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_textfield_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/shared/curved_background_widget.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final ForgetPasswordModel _model = ForgetPasswordModel();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _model.sendPasswordResetEmail();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reset link sent to ${_model.emailController.text}'),
            duration: Duration(seconds: 5),
          ),
        );
        Navigator.pushNamed(context, '/otp_view');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), duration: Duration(seconds: 5)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        iconColor: Colors.white,
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: Stack(
        children: [
          CustomPaint(
            size: Size(screenWidth, 300),
            painter: CurvedBackgroundPainter(context),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTitleSection(
                      title: "Forgot Password",
                      subtitle:
                          "Don’t worry! It happens. Please enter the email associated with your account.",
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      titleColor: Colors.white, 
                      subtitleColor: Colors.white.withValues(alpha: 0.7),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Image.asset(
                      "assets/images/otp/forget_pass.png",
                      width: screenWidth * 0.8,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    CustomTextField(
                      label: "Email address",
                      hint: "example123@gmail.com",
                      controller: _model.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Center(
                      child: ButtonWidget(
                        text: "Send",
                        width: screenWidth * 0.7,
                        height: screenHeight * 0.06,
                        onPressed: _isLoading ? null : _sendResetEmail,
                        isLoading: _isLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
