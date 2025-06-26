import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';
import '../../models/applocalization.dart';
import '../../models/user_type.dart';
import '../../widgets/custom_widgets/edit_profile_header.dart';
import '../../widgets/custom_widgets/edit_profile_info_tile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: BlocProvider.of<ProfileCubit>(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            loc.translate("edit_profile"),
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
            final isBusiness = state.userType == UserType.business;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Column(
                  children: [
                    EditProfileHeader(name: state.name),
                    const SizedBox(height: 24),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    const SizedBox(height: 24),
                    _buildEditProfileTile(
                      context,
                      icon: Icons.person,
                      title: 'Name',
                      value: state.name,
                      onEdit: (value) => context.read<ProfileCubit>().updateProfileField('Name', value),
                    ),
                    _buildEditProfileTile(
                      context,
                      icon: Icons.email,
                      title: 'Email',
                      value: state.email,
                      onEdit: (value) => context.read<ProfileCubit>().updateProfileField('Email', value),
                    ),
                    if (!isBusiness)
                      _buildEditProfileTile(
                        context,
                        icon: Icons.calendar_today,
                        title: 'Birth Date',
                        value: state.birthDate,
                        onEdit: (value) => context.read<ProfileCubit>().updateProfileField('Birth Date', value),
                      ),
                    _buildEditProfileTile(
                      context,
                      icon: Icons.location_on,
                      title: isBusiness ? 'Company Location' : 'Address',
                      value: state.location,
                      onEdit: (value) => context.read<ProfileCubit>().updateProfileField('Location', value),
                    ),
                    _buildEditProfileTile(
                      context,
                      icon: Icons.badge,
                      title: isBusiness ? 'Number of Employees' : 'National ID',
                      value: state.idNumber,
                      onEdit: (value) => context.read<ProfileCubit>().updateProfileField('ID Number', value),
                    ),
                    _buildEditProfileTile(
                      context,
                      icon: Icons.attach_money,
                      title: isBusiness ? 'Budget' : 'Income',
                      value: state.salary,
                      onEdit: (value) => context.read<ProfileCubit>().updateProfileField('Salary', value),
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

  Widget _buildEditProfileTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String value,
        required Function(String) onEdit,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFEDE7F6),
            child: Icon(icon, color: const Color(0xFF3E0555)),
          ),
          title: Text(
            value.isEmpty ? 'Not set' : value,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontFamily: 'Poppins'
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(context, title, value, onEdit),
          ),
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Edit $fieldName',
              style: TextStyle(
                fontFamily: "Poppins",
                color: isDarkMode ? Colors.white : const Color(0xFF3E0555),
              ),
            ),
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new $fieldName'),
            style: const TextStyle(fontFamily: "Poppins"),
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
                      color: isDarkMode ? Colors.white : const Color(0xFF3E0555),
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
                      color: isDarkMode ? Colors.white : const Color(0xFF3E0555),
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