package io.banana.dokkaexample.ui.team_list

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import io.banana.domain.models.Scuderia
import io.banana.domain.use_cases.GetTeamsUseCase
import io.banana.domain.view_models.ITeamsListViewModel
import kotlinx.coroutines.launch

class TeamListViewModel
constructor(
    private val getTeamsUseCaseImpl: GetTeamsUseCase
) : ViewModel(), ITeamsListViewModel {

    override val getTeamsUseCase: GetTeamsUseCase
        get() = getTeamsUseCaseImpl

    val onLoading: MutableLiveData<Boolean> = MutableLiveData()
    val onError: MutableLiveData<String> = MutableLiveData()
    val onEmptyList: MutableLiveData<String> = MutableLiveData()
    val onListLoaded: MutableLiveData<List<Scuderia>> = MutableLiveData()

    override fun start() {
        viewModelScope.launch {
            init()
        }
    }

    override fun onLoading(isLoading: Boolean) {
        onLoading.postValue(isLoading)
    }

    override fun onError(message: String) {
        onError.postValue(message)
    }

    override fun onEmptyList(message: String) {
        onEmptyList.postValue(message)
    }

    override fun onTeamLoaded(teams: List<Scuderia>) {
        onListLoaded.postValue(teams)
    }

}