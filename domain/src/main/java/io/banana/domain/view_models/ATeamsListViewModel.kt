package io.banana.domain.view_models

import io.banana.domain.models.Failure
import io.banana.domain.models.Scuderia
import io.banana.domain.models.Success
import io.banana.domain.use_cases.GetTeamsUseCase

interface ITeamsListViewModel {

    val getTeamsUseCase: GetTeamsUseCase

    fun onLoading(isLoading: Boolean)
    fun onError(message: String)
    fun onEmptyList(message: String)

    fun onTeamLoaded(teams: List<Scuderia>)
    fun start()

    suspend fun init() {
        onLoading(true)
        when (val result = getTeamsUseCase.execute()) {
            is Success -> {
                if (result.data.isEmpty()) {
                    onEmptyList("Empty list")
                } else {
                    onTeamLoaded(result.data)
                }
            }
            is Failure -> onError("Error getting data")
        }
        onLoading(false)
    }

}