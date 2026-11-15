import 'package:flutter/material.dart';
import 'package:latres/components/custom_buttom.dart';
import 'package:latres/components/custom_text_field.dart';
import 'package:latres/components/favorite_snackbar.dart';
import 'package:latres/pages/home_page.dart';
import 'package:latres/pages/register_page.dart';
import 'package:latres/services/auth_service.dart';
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

  @override
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    final isLogin = await AuthService.login(
      username: usernameController.text, 
      password: passwordController.text,
    );

    if(!mounted) return; 

    if(!isLogin){
      FavoriteSnackbar.show(context, message: "Wrong Username or Password!");
      return;  
    }

    FavoriteSnackbar.show(context, message: "Login Successful!"); 

    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: ((context) => HomePage())
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
                  'assets/img/login.png',
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
        
              Text("Your Portal Is Waiting!",
                style: AppTextStyles.heading
              ),
        
              Text("Ready for another interdimensional adventure?", 
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

              const SizedBox(height: 24,),

              CustomButton(
                text: "Enter the Portal",
                onPressed: handleLogin, 
              ),

              const SizedBox(height: 8,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont Have an account? ',
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
                      'Sign up',
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