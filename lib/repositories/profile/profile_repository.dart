import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/app_user.dart';

class ProfileRepository {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference coursesRef =
      FirebaseFirestore.instance.collection('courses');

  Future<DocumentSnapshot<AppUser>> getUser(String userId) async {
    return await usersRef
        .withConverter<AppUser>(
          fromFirestore: (snapshots, _) => AppUser.fromMap(
            (snapshots.data()!),
          ),
          toFirestore: (user, __) => user.toMap(),
        )
        .doc(userId)
        .get();
  }

  Stream<DocumentSnapshot<AppUser>> getUserSnapshot(String userId) {
    return usersRef
        .withConverter<AppUser>(
          fromFirestore: (snapshots, _) => AppUser.fromMap(
            (snapshots.data()!),
          ),
          toFirestore: (user, __) => user.toMap(),
        )
        .doc(userId)
        .snapshots();
  }
}
