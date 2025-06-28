import 'package:finyx_mobile_app/cubits/profile/profile_cubit.dart';
import 'package:finyx_mobile_app/models/password_page_type.dart';
import 'package:finyx_mobile_app/views/auth/forget_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_state.dart';
import '../../models/applocalization.dart';
import '../../widgets/buttons_widgets/custom_container_button.dart';
import '../../widgets/custom_widgets/dialogue.dart';
import '../../widgets/custom_widgets/user_profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadData();
    }
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileCubit>().loadUserData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          loc.translate("profile_title"),
          style: TextStyle(fontFamily: 'Righteous', fontSize: width * 0.06),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
              child: Column(
                children: [
                  UserProfileCard(
                    name: state.name,
                    email: state.email,
                    imagePath: state.imagePath,
                    additionalInfo: '',
                  ),
                  const SizedBox(height: 32),
                  CustomContainerButton(
                    text: loc.translate("edit_profile"),
                    icon: Icons.edit,
                    onPressed:
                        () =>
                            Navigator.pushNamed(context, '/edit_profile_view'),
                  ),
                  const SizedBox(height: 16),
                  CustomContainerButton(
                    text: loc.translate("change_password"),
                    icon: Icons.lock_outline,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ForgetPasswordView(
                                pageType: PasswordPageType.change,
                              ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomContainerButton(
                    text: loc.translate("delete_account"),
                    icon: Icons.delete_outline,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => Dialogue(
                              message: loc.translate(
                                "delete_account_confirmation",
                              ),
                              actionType: 'delete',
                            ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomContainerButton(
                    text: loc.translate("log_out"),
                    icon: Icons.logout,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => Dialogue(
                              message: loc.translate("logout_confirmation"),
                              actionType: 'logout',
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
