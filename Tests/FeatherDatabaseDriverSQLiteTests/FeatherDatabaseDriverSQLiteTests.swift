//
//  FeatherSQLDatabaseTests.swift
//  FeatherSQLDatabaseTests
//
//  Created by Tibor Bodecs on 2023. 01. 16..
//

import FeatherComponent
import FeatherDatabase
import FeatherDatabaseDriverSQLite
import FeatherDatabaseTesting
import NIO
import SQLiteKit
import XCTest

final class FeatherDatabaseDriverSQLiteTests: XCTestCase {

    func testUsingTestSuite() async throws {

        let registry = ComponentRegistry()

        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let threadPool = NIOThreadPool(numberOfThreads: 1)
        threadPool.start()

        let connectionSource = SQLiteConnectionSource(
            configuration: .init(
                storage: .memory,
                enableForeignKeys: true
            ),
            threadPool: threadPool
        )

        let pool = EventLoopGroupConnectionPool(
            source: connectionSource,
            on: eventLoopGroup
        )

        try await registry.addDatabase(
            SQLiteDatabaseComponentContext(
                pool: pool
            )
        )

        let db = try await registry.database()
        let testSuite = DatabaseTestSuite(db)
        try await testSuite.testAll()

        pool.shutdown()
        try await eventLoopGroup.shutdownGracefully()
    }
}
