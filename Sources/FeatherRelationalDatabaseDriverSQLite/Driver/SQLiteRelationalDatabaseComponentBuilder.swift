//
//  SQLDatabaseDriver.swift
//  FeatherComponentTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherComponent

import AsyncKit
import SQLiteKit

struct SQLiteRelationalDatabaseComponentBuilder: ComponentBuilder {

    let context: SQLiteRelationalDatabaseComponentContext
    let pool: EventLoopGroupConnectionPool<SQLiteConnectionSource>

    init(context: SQLiteRelationalDatabaseComponentContext) {
        self.context = context

        self.pool = EventLoopGroupConnectionPool(
            source: context.connectionSource,
            on: context.eventLoopGroup
        )
    }

    func build(using config: ComponentConfig) throws -> Component {
        SQLiteRelationalDatabaseComponent(config: config, pool: pool)
    }

    func shutdown() throws {
        pool.shutdown()
    }
}
