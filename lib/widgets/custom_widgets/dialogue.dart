import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:finyx_mobile_app/cubits/wallet/shared_pref_helper.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../models/applocalization.dart';

class Dialogue extends StatefulWidget {
  final String message;
  final String actionType;

  const Dialogue({Key? key, required this.message, required this.actionType})
    : super(key: key);

  @override
  State<Dialogue> createState() => _DialogueState();
}

class _DialogueState extends State<Dialogue> {
  final TextEditingController _inputController = TextEditingController();
  bool _isLoading = false;
  bool _showError = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

 Future<void> _handleAction(BuildContext context) async {
  setState(() {
    _isLoading = true;
    _showError = false;
  });

  final loc = AppLocalizations.of(context)!;
  final scaffold = ScaffoldMessenger.of(context);
  final user = FirebaseAuth.instance.currentUser;
  final profileCubit = context.read<ProfileCubit>();

  try {
    if (widget.actionType == 'logout') {
      // تسجيل الخروج من جوجل إذا كان مستخدم جوجل
      final googleSignIn = GoogleSignIn();
      try {
        await googleSignIn.disconnect();
      } catch (_) {}
      await googleSignIn.signOut();
      
      // تسجيل الخروج من Firebase
      await FirebaseAuth.instance.signOut();
      
      // مسح حالة تسجيل الدخول من SharedPreferences
      await SharedPrefsHelper.saveLoginState(false);
      
      // إعادة تعيين حالة البروفايل
      profileCubit.resetState();
      
      // إعادة التوجيه إلى شاشة تسجيل الدخول
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      }
      
      scaffold.showSnackBar(
        SnackBar(
          content: Text(loc.translate("logged_out_successfully")),
          backgroundColor: Colors.green,
        ),
      );
    } 
    else if (widget.actionType == 'delete') {
      // ... (الكود الحالي لحذف الحساب يبقى كما هو)
    }
  } catch (e) {
    scaffold.showSnackBar(
      SnackBar(
        content: Text('${loc.translate("error_occurred")}: ${e.toString()}'),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isDelete = widget.actionType == 'delete';
    final user = FirebaseAuth.instance.currentUser;
    final providerId = user?.providerData.first.providerId;
    final isGoogle = providerId == 'google.com';

    return Center(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: Colors.grey, width: 5),
        ),
        title: Text(
          widget.message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 20),
        ),
        content:
            isDelete
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      loc.translate("delete_warning"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withAlpha(150),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (widget.actionType == 'delete')
                      TextField(
                        controller: _inputController,
                        obscureText: !isGoogle,
                        keyboardType:
                            isGoogle
                                ? TextInputType.emailAddress
                                : TextInputType.text,
                        decoration: InputDecoration(
                          labelText:
                              isGoogle
                                  ? loc.translate("enter_email_to_confirm")
                                  : loc.translate("enter_password_to_confirm"),
                          errorText:
                              _showError
                                  ? loc.translate("invalid_input")
                                  : null,
                        ),
                      ),
                  ],
                )
                : null,
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          SizedBox(
            width: 110,
            child: TextButton(
              onPressed: _isLoading ? null : () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFBBC05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                loc.translate("cancel"),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF3E0555),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: TextButton(
              onPressed: _isLoading ? null : () => _handleAction(context),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF3E0555),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child:
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                        loc.translate("yes"),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}