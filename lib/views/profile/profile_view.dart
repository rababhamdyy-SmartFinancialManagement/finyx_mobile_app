import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../widgets/buttons_widgets/custom_container_button.dart';
import '../../widgets/custom_widgets/dialogue.dart';
import '../../widgets/custom_widgets/user_profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _showDeleteDialog(BuildContext context) async {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    final navigator = Navigator.of(context);
    final scaffold = ScaffoldMessenger.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const _DeleteAccountDialog(),
    );

    if (result == true) {
      try {
        await cubit.deleteAccount();
        scaffold.showSnackBar(
          const SnackBar(
            content: Text('تم حذف الحساب بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        navigator.pushNamedAndRemoveUntil('/login', (route) => false);
      } catch (e) {
        scaffold.showSnackBar(
          SnackBar(
            content: Text('خطأ في حذف الحساب: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'الملف الشخصي',
          style: TextStyle(fontFamily: 'Righteous', fontSize: width * 0.06),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          child: Column(
            children: [
              UserProfileCard(),
              const SizedBox(height: 32),
              CustomContainerButton(
                text: "تعديل الملف",
                icon: Icons.edit,
                onPressed:
                    () => Navigator.pushNamed(context, '/edit_profile_view'),
              ),
              const SizedBox(height: 16),
              CustomContainerButton(
                text: "تغيير كلمة السر",
                icon: Icons.lock_outline,
                onPressed:
                    () => Navigator.pushNamed(context, '/reset_password_view'),
              ),
              const SizedBox(height: 16),
              CustomContainerButton(
                text: "حذف الحساب",
                icon: Icons.delete_outline,
                onPressed: () => _showDeleteDialog(context),
              ),
              const SizedBox(height: 16),
              CustomContainerButton(
                text: "تسجيل الخروج",
                icon: Icons.logout,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => Dialogue(
                          message: "هل أنت متأكد من تسجيل الخروج؟",
                          onConfirm: () => Navigator.pop(context),
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteAccountDialog extends StatefulWidget {
  const _DeleteAccountDialog();

  @override
  State<_DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<_DeleteAccountDialog> {
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showError = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _confirmDelete() async {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    setState(() {
      _isLoading = true;
      _showError = false;
    });

    try {
      final isValid = await cubit.reauthenticate(_passwordController.text);
      if (isValid && mounted) {
        Navigator.of(context).pop(true);
      } else if (mounted) {
        setState(() {
          _showError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _showError = true;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: const BorderSide(color: Colors.grey, width: 2),
      ),
      title: const Text(
        'حذف الحساب',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'سيتم حذف حسابك بشكل دائم مع جميع البيانات',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'أدخل كلمة السر للتأكيد',
              border: const OutlineInputBorder(),
              errorText: _showError ? 'كلمة السر غير صحيحة' : null,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed:
                  _isLoading ? null : () => Navigator.pop(context, false),
              child: const Text(
                'إلغاء',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _confirmDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                disabledBackgroundColor: Colors.red.withOpacity(0.5),
              ),
              child:
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                        'حذف',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
            ),
          ],
        ),
      ],
    );
  }
}
