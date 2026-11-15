// pake flutter pub add shared_preferences
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:latres/components/favorite_snackbar.dart';
import 'package:latres/models/user_model.dart';

class AuthService {
  //akses HIVE BOX
  static Box<UserModel> get _userBox => Hive.box<UserModel>('users');

  //register akun 
  static Future<String?> register({
    required String username, required String password, required String confirmPassword,
  }) async {
    final cleanUsername = username.trim(); 

    //validasi inpur kosong 
    if(cleanUsername.isEmpty || password.isEmpty){
      return 'Username dan Password wajib diisi'; 
    }

    //validasi konfirmasi password
    if (password != confirmPassword) {
      return 'Password tidak cocok'; 
    }

    //cek username udh dipake 
    final usernameExist = _userBox.values.any((user) => user.username.toLowerCase() == cleanUsername.toLowerCase(),); 
    if (usernameExist) {
      return 'username sudah digunakan'; 
    }

    //buat object user 
    final newUser = UserModel(
      username: username, 
      password: password
    );

    //simpan ke HIVE 
    await _userBox.add(newUser); 

    return null; 
  } 
}