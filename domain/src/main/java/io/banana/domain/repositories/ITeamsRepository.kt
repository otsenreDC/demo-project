package io.banana.domain.repositories

import io.banana.domain.models.Result
import io.banana.domain.models.Scuderia

/**
 * Interface that defines the Repository for the entity Team.
 */
interface ITeamsRepository {
    /**
     * Return a list of Scuderias.
     *
     * @return Returns a [Result] containing a [List]<[Scuderia]>.
     */
    suspend fun list(): Result<List<Scuderia>>
}