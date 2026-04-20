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
    ],
    targets: [
        .target(
            name: "ChatTextApp",
			dependencies: [
                
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