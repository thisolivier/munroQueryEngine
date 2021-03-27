// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MunroQueryEngine",
    platforms: [
        .macOS(.v10_14), .iOS(.v13), .tvOS(.v13)
    ],
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
            resources: [.copy("defaultMunroData.csv")]
        ),
        .testTarget(
            name: "MunroQueryEngineTests",
            dependencies: ["MunroQueryEngine"]
        ),
        .binaryTarget(
            name: "SomeLocalBinaryPackage",
            path: "MunroTestApp/to/some.xcframework"
        )
    ]
)
