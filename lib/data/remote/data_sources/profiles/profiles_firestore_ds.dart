import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_option/either_option.dart';
import 'package:project_docere/data/remote/dtos/profile_dto.dart';
import 'package:project_docere/domain/data_sources/profiles_data_source.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/profile.dart';

class ProfilesFirestoreDataSource extends IProfilesDataSource {
  final String _keyProfilesCollection = "profiles";

  final FirebaseFirestore _firestore;

  ProfilesFirestoreDataSource(this._firestore);

  @override
  Future<Either<Failure, Profile>> getByEmail(String email) async {
    try {
      final query = _firestore
          .collection(_keyProfilesCollection)
          .where("email", isEqualTo: email);

      final result = await query.get();

      final document = result.docs.first;

      final profileDTO = ProfileDTO.fromJson(
        id: document.id,
        json: document.data(),
      );

      return Right(profileDTO.toDomain());
    } catch (e) {
      print(e);
      return Left(Failure(cause: e));
    }
  }

  @override
  Future<Either<Failure, bool>> save(Profile profile) async {
    return Left(Failure(
        cause: Exception("This method is no implemented for Firestore")));
  }

  @override
  Either<Failure, Profile> current() {
    return Left(Failure(
        cause: Exception("This method is no implemented for Firestore")));
  }

  @override
  Either<Failure, bool> clear() {
    return Left(Failure(
        cause: Exception("This method is no implemented for Firestore")));
  }
}
