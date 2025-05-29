import 'package:flutter/material.dart';
import 'package:finyx_mobile_app/models/applocalization.dart';
import 'auth_footer_text_widget.dart';
import '../buttons_widgets/social_icon_button_widget.dart';
import '../../models/login_model.dart';

class SocialAuthButtons extends StatefulWidget {
  final bool isSignup;

  const SocialAuthButtons({super.key, this.isSignup = true});

  @override
  State<SocialAuthButtons> createState() => _SocialAuthButtonsState();
}

class _SocialAuthButtonsState extends State<SocialAuthButtons> {
  Future<String?> showUserTypeDialog(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.99,
            height: MediaQuery.of(context).size.height * 0.5,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: Colors.grey, width: 3),
              ),
              title: Text(
                loc.translate("select_user_type"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  _buildOptionTile(
                    context,
                    loc.translate("individual"),
                    "individual",
                  ),
                  const SizedBox(height: 10),
                  _buildOptionTile(
                    context,
                    loc.translate("business"),
                    "business",
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                SizedBox(
                  width: 110,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFFBBC05),
                      foregroundColor: const Color(0xffB6B6B6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      loc.translate("cancel"),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xFF3E0555),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionTile(BuildContext context, String title, String value) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => Navigator.pop(context, value),
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF3E0555),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  height: 0.0,
                  thickness: 0.7,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color!.withAlpha(150),
                ),
              ),
              Text(
                loc.translate("RegisterWith"),
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color!.withAlpha(200),
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Divider(
                  height: 0.0,
                  thickness: 0.7,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color!.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenWidth * 0.05),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: screenWidth * 0.05,
          runSpacing: 10,
          children: [
            SocialIconButton(
              asset: "assets/images/icons/facebook.png",
              onTap: () async {
                // إضافة تسجيل الدخول بالفيسبوك لاحقًا
              },
              screenWidth: screenWidth,
            ),
            SocialIconButton(
              asset: "assets/images/icons/google.png",
              onTap: () async {
                final selectedUserType = await showUserTypeDialog(context);
                if (selectedUserType != null) {
                  final loginModel = LoginModel();
                  final userType = await loginModel.signInWithGoogle(context);
                  if (userType != null) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/homepage',
                      arguments: userType,
                    );
                  }
                }
              },
              screenWidth: screenWidth,
            ),
            SocialIconButton(
              asset: "assets/images/icons/apple.png",
              onTap: () async {
                // إضافة تسجيل الدخول بأبل لاحقًا
              },
              screenWidth: screenWidth,
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.07),
        AuthFooterText(isSignup: widget.isSignup, screenWidth: screenWidth),
      ],
    );
  }
}
