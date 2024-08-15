package com.giphy.giphy_flutter_sdk.dto

import com.giphy.sdk.core.network.response.ErrorResponse

class GiphyApiException(private val original: Throwable) : Exception(original) {

    val errorResponse: ErrorResponse? by lazy {
        try {
            val errorResponseField = original::class.java.getDeclaredField("errorResponse")
            errorResponseField.isAccessible = true
            errorResponseField.get(original) as? ErrorResponse
        } catch (e: Exception) {
            null
        }
    }

    val errorMessage: String
        get() = errorResponse?.message ?: (errorResponse?.meta?.msg ?: "Unknown Error")
}
