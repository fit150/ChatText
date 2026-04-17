import ProjectDescription

let project = Project(
    name: "ChatText",
    
    packages: [
        .local(path: "ChatText.swiftpm")
    ],
    
    targets: [
        .target(
            name: "ChatText",
            destinations: [.iPhone, .iPad],
            product: .app,
            bundleId: "app.fit150.ChatText",
            deploymentTargets: .iOS("26.2"),
            
            infoPlist: .extendingDefault(
                with: [
                    "ITSAppUsesNonExemptEncryption": false,
                    "UILaunchScreen": ["UILaunchScreen": true],
                    "NSMicrophoneUsageDescription": "need mic",
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait",
                        "UIInterfaceOrientationLandscapeLeft",
                        "UIInterfaceOrientationLandscapeRight"
                    ],
                    "UISupportedInterfaceOrientations~ipad": [
                        "UIInterfaceOrientationPortrait",
                        "UIInterfaceOrientationPortraitUpsideDown",
                        "UIInterfaceOrientationLandscapeLeft",
                        "UIInterfaceOrientationLandscapeRight"
                    ]
                ]
            ),
            
            sources: ["ChatText/**"],
            
            // 1. scripts 必须在 dependencies 之前
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
            ],
            
            // 2. dependencies 在 scripts 之后
            dependencies: [
                .target(name: "ChatTextApp"),
                .xcframework(path: "Python.xcframework")
            ],
            
            // 3. settings 通常在最后
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
                debug: [
                    "CODE_SIGN_STYLE": "Automatic",
                    "DEVELOPMENT_TEAM": "89XHWPF6B6",
                ],
                release: [
                    "CODE_SIGN_STYLE": "Manual",
                    "DEVELOPMENT_TEAM": "89XHWPF6B6",
                    "CODE_SIGN_IDENTITY": "Apple Distribution",
                    "PROVISIONING_PROFILE_SPECIFIER": "match AppStore app.fit150.ChatText",
                ]
            )
        )
    ]
)
