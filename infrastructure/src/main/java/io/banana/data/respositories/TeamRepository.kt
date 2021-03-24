package io.banana.data.respositories

import io.banana.domain.models.Failure
import io.banana.domain.models.Result
import io.banana.domain.models.Scuderia
import io.banana.domain.repositories.ITeamsRepository
import io.banana.domain.repositories.remote.ITeamsDataSource

class TeamRepository(private val remoteDataSource: ITeamsDataSource) : ITeamsRepository {
    override suspend fun list(): Result<List<Scuderia>> {
        return try {
            remoteDataSource.list()
        } catch (throwable: Throwable) {
            Failure(throwable)
        }
    }
}