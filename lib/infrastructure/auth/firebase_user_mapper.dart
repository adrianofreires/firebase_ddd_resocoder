import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_ddd_resocoder/domain/auth/user.dart';
import 'package:firebase_ddd_resocoder/domain/core/value_objects.dart';

extension FirebaseUserDomainX on firebase.User {
  User toDomain() {
    return User(
      id: UniqueID.fromUniqueString(uid) as String,
    );
  }
}