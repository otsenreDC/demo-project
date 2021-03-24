package io.banana.domain.models

/**
 * An encapsulation of a result.
 *
 * This class cannot be implemented.
 *
 * @property T Defines the output type.
 */
sealed class Result<out T : Any>

/**
 * Successful result of an invocation.
 *
 * Implements [Result].
 *
 * @property data The variable containing the result data.
 */
class Success<T : Any>(val data: T) : Result<T>()

/**
 * Failure result of an invocation.
 *
 * Implements [Result].
 *
 * @property throwable The [Throwable] that produced the failure.
 */
class Failure(val throwable: Throwable) : Result<Nothing>()
