import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/reset_password_model.dart';
import '../../models/applocalization.dart';
import '../../widgets/shared/password_reset_handler.dart';
import '../../widgets/shared/button_widget.dart';
import '../../widgets/custom_widgets/custom_textfield_widget.dart';
import '../../widgets/custom_widgets/custom_title_section.dart';
import '../../widgets/custom_widgets/custom_appbar.dart';
import '../../widgets/shared/curved_background_widget.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final ResetPasswordModel _model = ResetPasswordModel();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final loc = AppLocalizations.of(context)!;

    try {
      final handler = PasswordResetHandler();
      final email = _auth.currentUser?.email ?? '';

      if (email.isEmpty) {
        throw Exception(loc.translate('no_email_found_error'));
      }

      if (!await handler.verifyResetRequest(email)) {
        throw Exception(loc.translate('invalid_reset_request_error'));
      }

      await _model.updatePassword();
      await handler.markRequestAsUsed(email);

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${loc.translate("password_update_failed_error")}${e.toString()}'),
            duration: const Duration(seconds: 5),
          ),
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
    final loc = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      ),
      body: Stack(
        children: [
          CustomPaint(
            size: Size(screenWidth, 300),
            painter: CurvedBackgroundPainter(context),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.05,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    CustomTitleSection(
                      title: loc.translate("reset_password_title"),
                      subtitle: loc.translate("reset_password_subtitle"),
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    CustomTextField(
                      label: loc.translate("new_password_label"),
                      hint: loc.translate("new_password_hint"),
                      controller: _model.newPasswordController,
                      obscureText: _obscureNewPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.translate("enter_new_password_error");
                        }
                        if (value.length < 8) {
                          return loc.translate("password_too_short_error");
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    CustomTextField(
                      label: loc.translate("confirm_password_label"),
                      hint: loc.translate("confirm_password_hint"),
                      controller: _model.confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.translate("enter_confirm_password_error");
                        }
                        if (value != _model.newPasswordController.text) {
                          return loc.translate("passwords_do_not_match_error");
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Center(
                      child: ButtonWidget(
                        text: loc.translate("update_password_button"),
                        width: screenWidth * 0.7,
                        height: screenHeight * 0.06,
                        onPressed: _isLoading ? null : _updatePassword,
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
