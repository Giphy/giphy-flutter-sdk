// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "giphy_flutter_sdk",
    platforms: [
        // Giphy iOS SDK 2.4.0 and later require iOS 15.0, as does the podspec.
        .iOS("15.0")
    ],
    products: [
        .library(
            name: "giphy-flutter-sdk",
            targets: ["giphy_flutter_sdk"]
        )
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        // Upstream Giphy iOS SDK supports SPM since 2.x. Library product
        // is `GiphyUISDK` — the same module name the plugin's Swift code
        // already imports, so no source changes needed.
        .package(
            url: "https://github.com/Giphy/giphy-ios-sdk",
            exact: "2.4.0"
        )
    ],
    targets: [
        .target(
            name: "giphy_flutter_sdk",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "GiphyUISDK", package: "giphy-ios-sdk")
            ]
        )
    ]
)
