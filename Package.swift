// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-database-driver-sqlite",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "FeatherDatabaseDriverSQLite", targets: ["FeatherDatabaseDriverSQLite"]),
    ],
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-database", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/vapor/sqlite-kit", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "FeatherDatabaseDriverSQLite",
            dependencies: [
                .product(name: "FeatherDatabase", package: "feather-database"),
                .product(name: "SQLiteKit", package: "sqlite-kit"),
            ]
        ),
        .testTarget(
            name: "FeatherDatabaseDriverSQLiteTests",
            dependencies: [
                .target(name: "FeatherDatabaseDriverSQLite"),
            ]
        ),
    ]
)
