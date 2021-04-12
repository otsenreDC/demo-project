import 'package:either_option/either_option.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_docere/domain/data_sources/profiles_data_source.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/profile.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/services/session_service.dart';

class SessionService with ISessionService {
  final FirebaseAuth _auth;
  final IProfilesDataSource _profilesFirestoreDataSource;
  final IProfilesDataSource _profilesPreferencesDataSource;

  SessionService(
    this._auth,
    this._profilesFirestoreDataSource,
    this._profilesPreferencesDataSource,
  );

  @override
  Future<Either<Failure, bool>> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        print("no user");
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final profileResult =
          await _profilesFirestoreDataSource.getByEmail(email);

      final profile = profileResult.fold((failure) => null, (value) => value);

      if (profile == null) {
        return Left(ProfileNotFoundFailure());
      } else {
        final saveResult = await _profilesPreferencesDataSource.save(profile);
        return saveResult.fold((failure) => Left(failure), (value) {
          if (value)
            return Right(true);
          else
            return Left(Failure());
        });
      }

      return Right(true);
      // STORE DATA
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(UserNotRegisteredFailure());
      } else if (e.code == 'wrong-password') {
        return Left(WrongPasswordFailure());
      } else {
        return Left(UnknownSignInFailure(cause: e));
      }
    } catch (e) {
      return Left(UnknownSignInFailure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUser(String email) async {
    return Left(Failure(cause: Exception("Not implemented")));
  }

  @override
  Future<Either<Failure, bool>> saveProfile(Profile profile) async {
    final result = await _profilesPreferencesDataSource.save(profile);

    if (result.isRight) {
      return Right(true);
    } else {
      return Left(Failure());
    }
  }

  @override
  Either<Failure, Session> getSession() {
    final currentFirebaseUser = _auth.currentUser;

    final profileResult = _profilesPreferencesDataSource.getByCurrent();
    final profile = profileResult.fold((failure) => null, (profile) => profile);

    if (profile == null || currentFirebaseUser == null) {
      return Left(InvalidSessionFailure());
    }

    return Right(
      Session(
        profile.fullName,
        roleFromString(profile.role),
        profile.id,
        authentication: currentFirebaseUser.uid,
      ),
    );
  }

  void authenticateWithFacebook() {}

  void authenticateWithGmail() {}

  void authenticateWithApple() {}
}
