//
//  FeatherSQLDatabaseTests.swift
//  FeatherSQLDatabaseTests
//
//  Created by Tibor Bodecs on 2023. 01. 16..
//

import FeatherComponent
import FeatherDatabase
import FeatherDatabaseDriverSQLite
import NIO
import SQLiteKit
import XCTest

final class FeatherDatabaseDriverSQLiteTests: XCTestCase {

    func testExample() async throws {

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

        let db = try await registry.database().connection().sqlDatabase

        do {

            struct Galaxy: Codable {
                let id: Int
                let name: String
            }

            try await db
                .create(table: "galaxies")
                .ifNotExists()
                .column("id", type: .int, .primaryKey(autoIncrement: false))
                .column("name", type: .text)
                .run()

            try await db.delete(from: "galaxies").run()

            try await db
                .insert(into: "galaxies")
                .columns("id", "name")
                .values(SQLBind(1), SQLBind("Milky Way"))
                .values(SQLBind(2), SQLBind("Andromeda"))
                .run()

            let galaxies =
                try await db
                .select()
                .column("*")
                .from("galaxies")
                .all(decoding: Galaxy.self)

            print("------------------------------")
            for galaxy in galaxies {
                print(galaxy.id, galaxy.name)
            }
            print("------------------------------")
        }
        catch {
            XCTFail("\(error)")
        }

        pool.shutdown()
        try await eventLoopGroup.shutdownGracefully()
    }
}
