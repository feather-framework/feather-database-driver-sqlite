//
//  FeatherSQLDatabaseTests.swift
//  FeatherSQLDatabaseTests
//
//  Created by Tibor Bodecs on 2023. 01. 16..
//

import NIO
import XCTest
import FeatherService
import FeatherRelationalDatabase
import FeatherRelationalDatabaseDriverSQLite
import SQLiteKit

final class FeatherRelationalDatabaseDriverSQLiteTests: XCTestCase {

    func testExample() async throws {
        do {
            let registry = ServiceRegistry()

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

            try await registry.addRelationalDatabase(
                SQLiteRelationalDatabaseServiceContext(
                    eventLoopGroup: eventLoopGroup,
                    connectionSource: connectionSource
                )
            )

            try await registry.run()
            let dbService = try await registry.relationalDatabase()
            let db = try await dbService.connection()

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

                try await registry.shutdown()
            }
            catch {
                try await registry.shutdown()

                throw error
            }
        }
        catch {
            XCTFail("\(error)")
        }

    }
}
