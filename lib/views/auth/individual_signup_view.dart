import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:flutter/material.dart';
import '../../models/individual_signup_model.dart';
import '../../widgets/shared/button_widget.dart';
import '../../widgets/custom_widgets/custom_textfield_widget.dart';
import '../../widgets/splash/finyx_widget.dart';
import '../../models/applocalization.dart';

class IndividualSignupView extends StatefulWidget {
  const IndividualSignupView({super.key});

  @override
  State<IndividualSignupView> createState() => _IndividualSignupViewState();
}

class _IndividualSignupViewState extends State<IndividualSignupView> {
  final IndividualSignupModel signupModel = IndividualSignupModel();

  @override
  void dispose() {
    signupModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.01),
                FinyxWidget(fontSize: screenWidth * 0.14),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.066,
                      width: screenWidth * 0.25,
                      child: TextFormField(
                        initialValue: "+20",
                        textAlign: TextAlign.center,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: loc.translate("country_code"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.black.withAlpha(20),
                          isDense: false,
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: CustomTextField(
                        label: loc.translate("phone_number"),
                        hint: loc.translate("enter_phone_number"),
                        controller: signupModel.phoneNumberController,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: loc.translate("dob"),
                  hint: loc.translate("dob_format"),
                  controller: signupModel.dobController,
                  readOnly: true,
                  keyboardType: TextInputType.none,
                  onTap: () => signupModel.pickDOB(context),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: loc.translate("address"),
                  hint: loc.translate("enter_address"),
                  controller: signupModel.addressController,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: loc.translate("monthly_income"),
                  hint: loc.translate("enter_income"),
                  controller: signupModel.incomeController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: loc.translate("national_id"),
                  hint: loc.translate("enter_national_id"),
                  controller: signupModel.nationalIdController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.06),
                ButtonWidget(
                  text: loc.translate("sign_up"),
                  onPressed: () async {
                    bool success = await signupModel.saveIndividualData(
                      context,
                    );
                    if (success) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/homepage',
                        arguments: UserType.individual,
                      );
                    }
                  },
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.06,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
