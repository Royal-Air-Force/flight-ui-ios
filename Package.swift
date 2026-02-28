// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "FlightUI",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "FlightUI",
            targets: ["FlightUI"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FlightUI",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "FlightUITests",
            dependencies: [
                "FlightUI"
            ]
        )
    ]
)
