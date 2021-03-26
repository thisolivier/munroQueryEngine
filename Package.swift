// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MunroQueryEngine",
    products: [
        .library(
            name: "MunroQueryEngine",
            targets: ["MunroQueryEngine"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MunroQueryEngine",
            dependencies: [],
            resources: [.copy("munrotab_v6.2.csv")]
        ),
        .testTarget(
            name: "MunroQueryEngineTests",
            dependencies: ["MunroQueryEngine"],
            resources: [.copy("munrotab_v6.2.csv")]
        )
    ]
)
