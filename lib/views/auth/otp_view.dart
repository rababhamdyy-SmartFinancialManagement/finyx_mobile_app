import 'package:finyx_mobile_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:finyx_mobile_app/widgets/custom_widgets/custom_title_section.dart';
import 'package:finyx_mobile_app/widgets/shared/curved_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/otp_model.dart';
import 'package:finyx_mobile_app/widgets/shared/button_widget.dart';


class OtpView extends StatefulWidget {
  final String email;
  const OtpView({super.key, required this.email});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final OtpModel _model = OtpModel();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _sendOtp();
  }

  Future<void> _sendOtp() async {
    setState(() => _isLoading = true);
    try {
      await _model.sendOtpToEmail(widget.email);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('OTP sent successfully!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await _model.verifyOtp();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/reset_password_view');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenSize = MediaQuery.of(context).size;
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
          Center(
            child: Padding(
              padding: EdgeInsets.all(screenSize.width * 0.01),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTitleSection(
                      title: "OTP Verification",
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      titleColor: Colors.white,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Image.asset(
                      "assets/images/otp/otp.png",
                      width: screenWidth * 0.9,
                    ),

                    SizedBox(height: screenHeight * 0.07),
                    ButtonWidget(
                      text: "Resend OTP",
                      onPressed: _isLoading ? null : _sendOtp,
                      isLoading: _isLoading,
                      width: screenSize.width * 0.8,
                      height: screenSize.height * 0.07,
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

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}
