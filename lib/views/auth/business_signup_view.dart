import 'package:finyx_mobile_app/models/user_type.dart';
import 'package:flutter/material.dart';
import '../../models/business_signup_model.dart';
import '../../widgets/auth_widgets/auth_options_widget.dart';
import '../../widgets/shared/button_widget.dart';
import '../../widgets/custom_widgets/custom_textfield_widget.dart';
import '../../widgets/splash/finyx_widget.dart';
import '../../models/applocalization.dart';

class BusinessSignUpView extends StatefulWidget {
  const BusinessSignUpView({super.key});

  @override
  State<BusinessSignUpView> createState() => _BusinessSignUpViewState();
}

class _BusinessSignUpViewState extends State<BusinessSignUpView> {
  final BusinessSignUpModel signUpModel = BusinessSignUpModel();

  @override
  void dispose() {
    signUpModel.dispose();
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
                CustomTextField(
                  label: loc.translate("full_name"),
                  hint: loc.translate("enter_full_name"),
                  controller: signUpModel.fullNameController,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: loc.translate("company_name"),
                  hint: "com.example.company",
                  controller: signUpModel.companyNameController,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: loc.translate("company_location"),
                  hint: "Egypt",
                  controller: signUpModel.companyLocationController,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: loc.translate("monthly_income"),
                  hint: loc.translate("enter_income"),
                  controller: signUpModel.budgetController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  label: loc.translate("number_of_employees"),
                  hint: loc.translate("enter_number_of_employees"),
                  controller: signUpModel.numberOfEmployeesController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.03),
                ButtonWidget(
                  text: loc.translate("sign_up"),
                  onPressed: () async {
                    bool success = await signUpModel.saveBusinessData(context);
                    if (success) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/homepage',
                        arguments: UserType.business,
                      );
                    }
                  },
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.06,
                ),
                SizedBox(height: screenHeight * 0.04),
                SocialAuthButtons(isSignup: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
