// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "ChatTextApp",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "ChatTextApp",
            targets: ["ChatTextApp"]
        )
    ],
    dependencies: [
//        .package(
//            url: "https://github.com/ml-explore/mlx-swift-lm.git",
//            branch: "main"
//        )
    ],
    targets: [
        .target(
            name: "ChatTextApp",
            dependencies: [
//                .product(name: "MLXLLM", package: "mlx-swift-lm")
            ],
            path: ".",
            exclude: [
                ".git",
                "README.md"
            ],
            resources: [
                .copy("CopyResources")
            ]
        )
    ]
)