//
//  File 2.swift
//
//
//  Created by Tibor Bodecs on 03/12/2023.
//

import FeatherComponent
import FeatherRelationalDatabase
import SQLKit
import SQLiteKit
@preconcurrency import AsyncKit

@dynamicMemberLookup
struct SQLiteRelationalDatabaseComponent: RelationalDatabaseComponent {

    public let config: ComponentConfig
    let pool: EventLoopGroupConnectionPool<SQLiteConnectionSource>

    subscript<T>(
        dynamicMember keyPath: KeyPath<
            SQLiteRelationalDatabaseComponentContext, T
        >
    ) -> T {
        let context = config.context as! SQLiteRelationalDatabaseComponentContext
        return context[keyPath: keyPath]
    }

    init(
        config: ComponentConfig,
        pool: EventLoopGroupConnectionPool<SQLiteConnectionSource>
    ) {
        self.config = config
        self.pool = pool
    }

    public func connection() async throws -> SQLKit.SQLDatabase {
        pool.database(logger: self.logger).sql()
    }

}
