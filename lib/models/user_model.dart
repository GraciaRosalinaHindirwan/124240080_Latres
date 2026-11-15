//flutter pub add hive hive_flutter 
//flutter pub add dev:build_runner
// flutter pub add dev:hive_generator
//jalankan : dart run build_runner build --delete-conflicting-outputs

import 'package:hive/hive.dart';
part 'user_model.g.dart'; //adapter

@HiveType(typeId: 0)
class UserModel extends HiveObject{
  @HiveField(0)
  final String username; 
  
  @HiveField(1)
  final String password; 

  UserModel({
    required this.username, 
    required this.password, 
  });
}