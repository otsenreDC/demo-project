import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/data_sources/profiles_data_source.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilesPreferencesDataSource extends IProfilesDataSource {
  final String _keyId = "id";
  final String _keyEmail = "email";
  final String _keyName = "name";
  final String _keyLastName = "lastName";
  final String _keyRole = "role";

  final SharedPreferences _preferences;

  ProfilesPreferencesDataSource(this._preferences);

  @override
  Future<Either<Failure, Profile>> getByEmail(String email) async {
    return Left(Failure(cause: Exception("No implemented")));
  }

  @override
  Future<Either<Failure, bool>> save(Profile profile) async {
    try {
      await _preferences.setString(_keyId, profile.id);
      await _preferences.setString(_keyEmail, profile.email);
      await _preferences.setString(_keyName, profile.name);
      await _preferences.setString(_keyLastName, profile.lastName);
      await _preferences.setString(_keyRole, profile.role);

      return Right(true);
    } catch (e) {
      return Left(Failure.withCause(e));
    }
  }

  @override
  Either<Failure, Profile> getByCurrent() {
    try {
      final id = _preferences.getString(_keyId);
      final email = _preferences.getString(_keyEmail);
      final name = _preferences.getString(_keyName);
      final lastName = _preferences.getString(_keyLastName);
      final role = _preferences.getString(_keyRole);

      if (id == null || email == null || role == null) {
        return Left(ProfileNotFoundFailure());
      } else {
        return Right(Profile(
          id: id,
          email: email,
          name: name,
          lastName: lastName,
          role: role,
        ));
      }
    } catch (e) {
      return Left(Failure.withCause(e));
    }
  }
}
