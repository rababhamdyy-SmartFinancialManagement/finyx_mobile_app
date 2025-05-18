import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';
import '../../widgets/custom_widgets/edit_profile_header.dart';
import '../../widgets/custom_widgets/edit_profile_info_tile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(FlutterLocalNotificationsPlugin()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
            style: TextStyle(
              fontFamily: 'Righteous',
              fontSize: MediaQuery.of(context).size.width * 0.06,
            ),
          ),
          centerTitle: true,
          foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
          elevation: 0,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Column(
                  children: [
                    EditProfileHeader(name: state.name),
                    const SizedBox(height: 24),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    const SizedBox(height: 24),
                    EditProfileInfoTile(
                      iconPath: "assets/images/profile/User(1).png",
                      text: state.name,
                      fieldName: 'Name',
                      onEdit:
                          () => _showEditDialog(context, 'Name', state.name, (
                            value,
                          ) {
                            context.read<ProfileCubit>().updateProfileField(
                              'Name',
                              value,
                            );
                          }),
                    ),
                    EditProfileInfoTile(
                      iconPath: "assets/images/profile/🦆 icon _mail_.png",
                      text: state.email,
                      fieldName: 'Email',
                      onEdit:
                          () => _showEditDialog(context, 'Email', state.email, (
                            value,
                          ) {
                            context.read<ProfileCubit>().updateProfileField(
                              'Email',
                              value,
                            );
                          }),
                    ),
                    EditProfileInfoTile(
                      iconPath: "assets/images/profile/calendar 1.png",
                      text: state.birthDate,
                      fieldName: 'Birth Date',
                      onEdit:
                          () => _showEditDialog(
                            context,
                            'Birth Date',
                            state.birthDate,
                            (value) {
                              context.read<ProfileCubit>().updateProfileField(
                                'Birth Date',
                                value,
                              );
                            },
                          ),
                    ),
                    EditProfileInfoTile(
                      iconPath: "assets/images/profile/location 1.png",
                      text: state.location,
                      fieldName: 'Location',
                      onEdit:
                          () => _showEditDialog(
                            context,
                            'Location',
                            state.location,
                            (value) {
                              context.read<ProfileCubit>().updateProfileField(
                                'Location',
                                value,
                              );
                            },
                          ),
                    ),
                    EditProfileInfoTile(
                      iconPath: "assets/images/profile/id 1.png",
                      text: state.idNumber,
                      fieldName: 'ID Number',
                      onEdit:
                          () => _showEditDialog(
                            context,
                            'ID Number',
                            state.idNumber,
                            (value) {
                              context.read<ProfileCubit>().updateProfileField(
                                'ID Number',
                                value,
                              );
                            },
                          ),
                    ),
                    EditProfileInfoTile(
                      iconPath: "assets/images/profile/wages 1.png",
                      text: state.salary,
                      fieldName: 'Salary',
                      onEdit:
                          () => _showEditDialog(
                            context,
                            'Salary',
                            state.salary,
                            (value) {
                              context.read<ProfileCubit>().updateProfileField(
                                'Salary',
                                value,
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String fieldName, 
    String currentValue,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Edit $fieldName',
              style: TextStyle(
                fontFamily: "Poppins",
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Color(0xFF3E0555),
              ),
            ),
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new $fieldName'),
            style: TextStyle(fontFamily: "Poppins"),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xFF3E0555),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    onSave(controller.text);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xFF3E0555),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
