import 'package:finyx_mobile_app/models/PasswordPageType.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/forget_password_model.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_textfield_widget.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/shared/curved_background_widget.dart';

class ForgetPasswordView extends StatefulWidget {
  final PasswordPageType pageType;

  const ForgetPasswordView({super.key, required this.pageType});

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
            content: Text('${loc.translate("reset_link_sent")} ${_model.emailController.text}'),
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

  late AppLocalizations loc;

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    loc = AppLocalizations.of(context)!;

    String title;
    String subtitle;

    switch (widget.pageType) {
      case PasswordPageType.forget:
        title = loc.translate("forgot_password_title");
        subtitle = loc.translate("forgot_password_subtitle");
        break;
      case PasswordPageType.change:
        title = loc.translate("change_password_title");
        subtitle = loc.translate("change_password_subtitle");
        break;
    }

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
                      title: title,
                      subtitle: subtitle,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      titleColor: Colors.white,
                      subtitleColor: Colors.white.withOpacity(0.7),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Image.asset(
                      "assets/images/otp/forget_pass.png",
                      width: screenWidth * 0.8,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    CustomTextField(
                      label: loc.translate("email_label"),
                      hint: loc.translate("email_hint"),
                      controller: _model.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.translate("email_required");
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return loc.translate("invalid_email");
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Center(
                      child: ButtonWidget(
                        text: loc.translate("send_button"),
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
