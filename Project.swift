import ProjectDescription

let project = Project(
    name: "ChatText",
    
    packages: [
        .package(path: "ChatText.swiftpm")
    ],
    
    targets: [
        Target(
            name: "ChatText",
            platform: .iOS,
            product: .app,
            bundleId: "app.fit150.ChatText",
            
            // 使用当前最新 iOS 版本
            deploymentTarget: .iOS(targetVersion: "26.2", devices: [.iphone, .ipad]),
            
            infoPlist: .extendingDefault(with: [
                "ITSAppUsesNonExemptEncryption": .boolean(false),
                "UILaunchScreen": .dictionary(["UILaunchScreen": .boolean(true)]),
                "NSMicrophoneUsageDescription": .string("need mic"),
                "UISupportedInterfaceOrientations": .array([
                    .string("UIInterfaceOrientationPortrait"),
                    .string("UIInterfaceOrientationLandscapeLeft"),
                    .string("UIInterfaceOrientationLandscapeRight")
                ]),
                "UISupportedInterfaceOrientations~ipad": .array([
                    .string("UIInterfaceOrientationPortrait"),
                    .string("UIInterfaceOrientationPortraitUpsideDown"),
                    .string("UIInterfaceOrientationLandscapeLeft"),
                    .string("UIInterfaceOrientationLandscapeRight")
                ])
            ]),
            
            // 使用 /** 展开内部文件结构，等效于 XcodeGen 的黄色文件夹
            sources: ["ChatText/**"], 
            
            dependencies: [
                .target(name: "ChatTextApp"),
                .xcframework(path: "Python.xcframework", codeSign: true)
            ],
            
            settings: .settings(
                base: [
                    "GENERATE_INFOPLIST_FILE": "YES",
                    "MARKETING_VERSION": "0.1",
                    "CURRENT_PROJECT_VERSION": "1",
                    "ENABLE_USER_SCRIPT_SANDBOXING": "NO",
                    "ENABLE_TESTABILITY": "YES",
                    "FRAMEWORK_SEARCH_PATHS": "$(inherited) $(PROJECT_DIR)",
                    "HEADER_SEARCH_PATHS": "$(inherited) \"$(BUILT_PRODUCTS_DIR)/Python.framework/Headers\"",
                    "CLANG_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER": "NO",
                ],
                configurations: [
                    .debug(name: "Debug", settings: [
                        "CODE_SIGN_STYLE": "Automatic",
                        "DEVELOPMENT_TEAM": "89XHWPF6B6",
                    ]),
                    .release(name: "Release", settings: [
                        "CODE_SIGN_STYLE": "Manual",
                        "DEVELOPMENT_TEAM": "89XHWPF6B6",
                        "CODE_SIGN_IDENTITY": "Apple Distribution",
                        "PROVISIONING_PROFILE_SPECIFIER": "match AppStore app.fit150.ChatText",
                    ]),
                ]
            ),
            
            scripts: [
                .post(
                    script: """
                    set -e
                    
                    source "$PROJECT_DIR/Python.xcframework/build/utils.sh"
                    install_python Python.xcframework app
                    """,
                    name: "[Python] Handle",
                    basedOnDependencyAnalysis: false
                )
            ]
        )
    ]
)
