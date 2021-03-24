package io.banana.data.datasources

import io.banana.domain.models.Failure
import io.banana.domain.models.Result
import io.banana.domain.models.Scuderia
import io.banana.domain.models.Success
import io.banana.domain.repositories.remote.ITeamsDataSource
import kotlinx.coroutines.delay
import java.io.IOException

private val scuderias = listOf(
    "Mercedes",
    "Red Bull",
    "Ferrari",
    "Mclaren",
    "Aston Martin",
    "Alpine",
    "Williams",
    "Alfa Romeo",
    "Alpha Tauri",
    "Haas"
)

class TeamStaticDataSource : ITeamsDataSource {
    override suspend fun list(): Result<List<Scuderia>> {
        delay(5000)
        return Success(emptyList())
//        return Success(
//            scuderias.mapIndexed { index, scuderia ->
//                Scuderia(index, scuderia);
//            }
//        )
    }
}