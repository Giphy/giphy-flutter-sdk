package com.giphy.giphy_flutter_sdk.dto

import com.giphy.sdk.core.models.Media


fun Media.toHashMap(): HashMap<String, Any?> {
    return hashMapOf(
        "url" to this.url,
        "id" to this.id
    )
}
