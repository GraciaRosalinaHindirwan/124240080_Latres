import 'package:flutter/material.dart';
import 'package:latres/components/custom_buttom.dart';
import 'package:latres/components/custom_text_field.dart';
import 'package:latres/components/favorite_snackbar.dart';
import 'package:latres/pages/login_page.dart';
import 'package:latres/services/auth_service.dart';
import 'package:latres/utils/app_colors.dart';
import 'package:latres/utils/app_text_styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  Future<void> handleRegister() async {
    final result = await AuthService.register(
      username: usernameController.text, 
      password: passwordController.text, 
      confirmPassword: confirmPasswordController.text,
    ); 
    
    //jika registrasi gagal 
    if(result == null){
      FavoriteSnackbar.show(context, message: result.toString()); 
      return; 
    } 

    FavoriteSnackbar.show(context, message: "Account created success"); 
    Navigator.push(
      context, 
      MaterialPageRoute(builder: ((context) => LoginPage()), 
      ),
    );
    
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
                obscureText: true,
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
                text: "Create My Portal", 
                onPressed: handleRegister, 
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
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