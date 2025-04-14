import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_cubit.dart';

class Dialogue extends StatefulWidget {
  final String message;
  final String actionType;

  const Dialogue({Key? key, required this.message, required this.actionType})
    : super(key: key);

  @override
  State<Dialogue> createState() => _DialogueState();
}

class _DialogueState extends State<Dialogue> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showError = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleAction(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _showError = false;
    });

    final scaffold = ScaffoldMessenger.of(context);

    try {
      if (widget.actionType == 'logout') {
        await FirebaseAuth.instance.signOut();
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      } else if (widget.actionType == 'delete') {
        final cubit = BlocProvider.of<ProfileCubit>(context);
        final isValid = await cubit.reauthenticate(_passwordController.text);
        if (isValid) {
          await cubit.deleteAccount();
          scaffold.showSnackBar(
            const SnackBar(
              content: Text('Account deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/sign_up',
              (route) => false,
            );
          }
        } else {
          setState(() {
            _showError = true;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      scaffold.showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDelete = widget.actionType == 'delete';

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.99,
        height: MediaQuery.of(context).size.height * 0.99,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Colors.grey, width: 5),
          ),
          title: Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 20,
            ),
          ),
          content:
              isDelete
                  ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Your account and all data will be permanently deleted.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Enter your password to confirm',
                          border: const OutlineInputBorder(),
                          errorText: _showError ? 'Incorrect password' : null,
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
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xffB6B6B6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
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
                        : const Text(
                          'Yes',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
