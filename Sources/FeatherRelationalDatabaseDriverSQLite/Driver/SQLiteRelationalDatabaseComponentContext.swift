//
//  SQLDatabaseContext.swift
//  FeatherComponentTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherComponent
@preconcurrency import SQLiteKit

public struct SQLiteRelationalDatabaseComponentContext: ComponentContext {

    let pool: EventLoopGroupConnectionPool<SQLiteConnectionSource>

    public init(pool: EventLoopGroupConnectionPool<SQLiteConnectionSource>) {
        self.pool = pool
    }

    public func make() throws -> ComponentFactory {
        SQLiteRelationalDatabaseComponentFactory(context: self)
    }
}
