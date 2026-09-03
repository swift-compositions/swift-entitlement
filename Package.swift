// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-entitlement",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .macCatalyst(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Entitlement",
            targets: ["Entitlement"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Entitlement",
            dependencies: []
        ),
        .testTarget(
            name: "Entitlement Tests",
            dependencies: [
                .target(name: "Entitlement")
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
                .enableExperimentalFeature("Lifetimes"),
                .enableUpcomingFeature("InferIsolatedConformances"),
            ]
}
