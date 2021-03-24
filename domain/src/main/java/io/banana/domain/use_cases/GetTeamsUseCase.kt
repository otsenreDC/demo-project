package io.banana.domain.use_cases

import io.banana.domain.models.Failure
import io.banana.domain.models.Result
import io.banana.domain.models.Scuderia
import io.banana.domain.models.Success
import io.banana.domain.repositories.ITeamsRepository

data class GetTeamsUseCase(
    private val teamsRepository: ITeamsRepository
) {
    suspend fun execute(): Result<List<Scuderia>> {
        return try {
            when (val result = teamsRepository.list()) {
                is Success -> Success(result.data)
                is Failure -> Failure(result.throwable)
            }
        } catch (throwable: Throwable) {
            Failure(throwable)
        }
    }
}
