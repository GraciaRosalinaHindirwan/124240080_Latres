import 'package:flutter/material.dart';
import 'package:latres/components/custom_buttom.dart';
import 'package:latres/components/custom_text_field.dart';
import 'package:latres/utils/app_colors.dart';
import 'package:latres/utils/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController(); 
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Register Image
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/img/register.png',
                  width: double.infinity,
                  height: 354,
                  fit: BoxFit.contain,
                ),
              ),
          
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/img/logo.png',
                  width: 354,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
        
              Text("Get Your Own Portal!",
                style: AppTextStyles.heading
              ),
        
              Text("Every dimension has a story. Start exploring yours!", 
                style: AppTextStyles.body,
              ),

              const SizedBox(height: 24,), 
        
              CustomTextField(
                label: 'Username',
                hintText: 'Enter your username', 
                controller: usernameController,
                obscureText: false,
              ),
        
              const SizedBox(height: 8,), 
        
              CustomTextField(
                label: 'Password',
                hintText: 'Enter your password', 
                controller: passwordController,
                obscureText: false,
              ),
        
              const SizedBox(height: 8,), 
        
              CustomTextField(
                label: 'Confirm Password',
                hintText: 'Enter your confirm password', 
                controller: confirmPasswordController,
                obscureText: false,
              ),

              const SizedBox(height: 24,),

              CustomButton(
                text: "Create My Portal", onPressed: (){}
              ),

              const SizedBox(height: 8,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account? ',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      // Navigasi ke LoginPage
                    },
                    child: Text(
                      'Sign in',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}