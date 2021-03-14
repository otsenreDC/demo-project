import 'package:either_option/either_option.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/data/remote/dtos/calendar_dto.dart';
import 'package:project_docere/domain/data_sources/doctors_data_source.dart';
import 'package:project_docere/domain/helpers/netork_info_helper.dart';
import 'package:project_docere/domain/models/calendar.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/failure.dart';

abstract class IDoctorRepository {
  Future<Either<Failure, Calendar>> getCalendar(
    String doctorId,
    String centerId,
    String calendarReference,
    int year,
  );

  Future<Either<Failure, bool>> updateDaySlot(
    String doctorIdReference,
    String calendarIdReference,
    Day day,
    DaySlot daySlot,
  );
}

class DoctorRepository extends IDoctorRepository {
  final IDoctorRemoteDataSource remoteDataSource;
  final INetworkInfoHelper connectionChecker;

  DoctorRepository(
      {@required this.remoteDataSource, @required this.connectionChecker});

  @override
  Future<Either<Failure, Calendar>> getCalendar(
    String doctorId,
    String centerId,
    String calendarReference,
    int year,
  ) async {
    if (await connectionChecker.isConnected()) {
      try {
        final calendar = await remoteDataSource.getCalendar(
          doctorId,
          centerId,
          calendarReference,
          year,
        );

        return Right(calendar.toDomain());
      } on Exception {
        return Left(Failure());
      }
    } else {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateDaySlot(
    String doctorIdReference,
    String calendarIdReference,
    Day day,
    DaySlot daySlot,
  ) async {
    if (await connectionChecker.isConnected()) {
      try {
        await remoteDataSource.updateDaySlot(
          doctorIdReference,
          calendarIdReference,
          DayDTO(
            id: "${day.id}",
            holiday: day.holiday,
            workday: day.workday,
            daySlots: day.daySlots
                .map(
                  (slot) => DaySlotDTO.fromDomain(slot),
                )
                .toList(),
          ),
          DaySlotDTO.fromDomain(daySlot),
        );

        return Future.value(Right(true));
      } catch (e) {
        return Left(Failure());
      }
    } else {
      return Left(Failure());
    }
  }
}
