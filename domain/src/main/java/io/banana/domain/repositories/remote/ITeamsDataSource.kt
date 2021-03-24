package io.banana.domain.repositories.remote

import io.banana.domain.models.Result
import io.banana.domain.models.Scuderia

/**
 * Interface definition of a DataSource for the entity Team.
 */
interface ITeamsDataSource {
    /**
     * Returns a list of [Scuderia].
     *
     * @return Returns a [Result] containing the [List]<[Scuderia]> or a [Throwable].
     */
    suspend fun list(): Result<List<Scuderia>>
}