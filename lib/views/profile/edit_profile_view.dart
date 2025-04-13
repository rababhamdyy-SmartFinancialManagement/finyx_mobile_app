import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../cubits/profile/profile_state.dart';
import '../../widgets/custom_widgets/edit_profile_header.dart';
import '../../widgets/custom_widgets/edit_profile_info_tile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.11),
                  EditProfileHeader(name: state.name),
                  SizedBox(height: height * 0.03),
                  Divider(
                    color: const Color(0xFFCACACA),
                    thickness: 0.5,
                    indent: width * 0.01,
                    endIndent: width * 0.01,
                  ),
                  EditProfileInfoTile(
                    iconPath: "assets/images/profile/User(1).png",
                    text: state.name,
                    fieldName: 'Name',
                    onEdit: () => _showEditDialog(context, 'Name', state.name, (value) {
                      context.read<ProfileCubit>().updateName(value);
                    }),
                  ),
                  EditProfileInfoTile(
                    iconPath: "assets/images/profile/🦆 icon _mail_.png",
                    text: state.email,
                    fieldName: 'Email',
                    onEdit: () => _showEditDialog(context, 'Email', state.email, (value) {
                      context.read<ProfileCubit>().updateEmail(value);
                    }),
                  ),
                  EditProfileInfoTile(
                    iconPath: "assets/images/profile/calendar 1.png",
                    text: state.birthDate,
                    fieldName: 'Birth Date',
                    onEdit: () => _showEditDialog(context, 'Birth Date', state.birthDate, (value) {
                      context.read<ProfileCubit>().updateBirthDate(value);
                    }),
                  ),
                  EditProfileInfoTile(
                    iconPath: "assets/images/profile/location 1.png",
                    text: state.location,
                    fieldName: 'Location',
                    onEdit: () => _showEditDialog(context, 'Location', state.location, (value) {
                      context.read<ProfileCubit>().updateLocation(value);
                    }),
                  ),
                  EditProfileInfoTile(
                    iconPath: "assets/images/profile/id 1.png",
                    text: state.idNumber,
                    fieldName: 'ID Number',
                    onEdit: () => _showEditDialog(context, 'ID Number', state.idNumber, (value) {
                      context.read<ProfileCubit>().updateIdNumber(value);
                    }),
                  ),
                  EditProfileInfoTile(
                    iconPath: "assets/images/profile/wages 1.png",
                    text: state.salary,
                    fieldName: 'Salary',
                    onEdit: () => _showEditDialog(context, 'Salary', state.salary, (value) {
                      context.read<ProfileCubit>().updateSalary(value);
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, String fieldName, String currentValue, Function(String) onSave) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $fieldName'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new $fieldName'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}