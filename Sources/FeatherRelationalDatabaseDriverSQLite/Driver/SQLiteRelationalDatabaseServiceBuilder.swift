//
//  SQLDatabaseDriver.swift
//  FeatherServiceTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherService

import AsyncKit
import SQLiteKit

struct SQLiteRelationalDatabaseServiceBuilder: ServiceBuilder {

    let context: SQLiteRelationalDatabaseServiceContext
    let pool: EventLoopGroupConnectionPool<SQLiteConnectionSource>

    init(context: SQLiteRelationalDatabaseServiceContext) {
        self.context = context

        self.pool = EventLoopGroupConnectionPool(
            source: context.connectionSource,
            on: context.eventLoopGroup
        )
    }

    func build(using config: ServiceConfig) throws -> Service {
        SQLiteRelationalDatabaseService(config: config, pool: pool)
    }

    func shutdown() throws {
        pool.shutdown()
    }
}
