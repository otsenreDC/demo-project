package io.banana.domain.models

/**
 * A data class representing a racing team.
 *
 * A scuderia may contains an [id], and a [name].
 *
 * @constructor
 *
 * @property id Unique identifier.
 * @property name Name of the Scuderia.
 */
data class Scuderia(
    val id: Int,
    val name: String,
) {

    /**
     * Returns a string representation of a [Scuderia].
     *
     * @return A string representation of the object.
     */
    override fun toString(): String = "[$id] $name"
}
