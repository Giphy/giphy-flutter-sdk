package com.giphy.giphy_flutter_sdk.utils
fun <T : Any> T?.require(errorMessage: String = "Required value was null"): T {
    return this ?: throw IllegalStateException(errorMessage)
}