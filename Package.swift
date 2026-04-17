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
        .package(
            url: "https://github.com/pvieito/PythonKit",
            branch: "master"
        )
    ],
    targets: [
        .target(
            name: "ChatTextApp",
			dependencies: [
                .product(name: "PythonKit", package: "PythonKit")
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