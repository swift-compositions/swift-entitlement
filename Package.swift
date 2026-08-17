// swift-tools-version: 6.3.3

import PackageDescription

extension String {
    static let entitlement: Self = "Entitlement"
    var tests: Self { self + " Tests" }
}

extension Target.Dependency {
    static var entitlement: Self { .target(name: .entitlement) }
}

let package = Package(
    name: "swift-entitlement",
    platforms: [
        .macOS("27"),
        .iOS("27"),
        .macCatalyst(.v26),
        .tvOS("27"),
        .watchOS("27"),
        .visionOS("27"),
    ],
    products: [
        .library(
            name: .entitlement,
            targets: [.entitlement]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: .entitlement,
            dependencies: []
        ),
        .testTarget(
            name: .entitlement.tests,
            dependencies: [
                .entitlement
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
            .enableExperimentalFeature("LifetimeDependence"),
            .enableExperimentalFeature("Lifetimes"),
            .enableExperimentalFeature("SuppressedAssociatedTypes"),
            .enableUpcomingFeature("InferIsolatedConformances"),
            .enableUpcomingFeature("LifetimeDependence"),
        ]
}
