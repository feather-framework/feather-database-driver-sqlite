// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-relational-database-driver-sqlite",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "FeatherRelationalDatabaseDriverSQLite", targets: ["FeatherRelationalDatabaseDriverSQLite"]),
    ],
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-relational-database", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/vapor/sqlite-kit", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "FeatherRelationalDatabaseDriverSQLite",
            dependencies: [
                .product(name: "FeatherRelationalDatabase", package: "feather-relational-database"),
                .product(name: "SQLiteKit", package: "sqlite-kit"),
            ]
        ),
        .testTarget(
            name: "FeatherRelationalDatabaseDriverSQLiteTests",
            dependencies: [
                .target(name: "FeatherRelationalDatabaseDriverSQLite"),
            ]
        ),
    ]
)
