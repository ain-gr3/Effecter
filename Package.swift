// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Effecter",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "Effecter",
            targets: ["Effecter"]),
    ],
    targets: [
        .target(
            name: "Effecter"),
    ]
)
