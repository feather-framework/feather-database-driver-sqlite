//
//  File 2.swift
//
//
//  Created by Tibor Bodecs on 03/12/2023.
//

import FeatherService
import FeatherRelationalDatabase
import SQLKit
import SQLiteKit
@preconcurrency import AsyncKit

@dynamicMemberLookup
struct SQLiteRelationalDatabaseService: RelationalDatabaseService {

    public let config: ServiceConfig
    let pool: EventLoopGroupConnectionPool<SQLiteConnectionSource>

    subscript<T>(
        dynamicMember keyPath: KeyPath<
            SQLiteRelationalDatabaseServiceContext, T
        >
    ) -> T {
        let context = config.context as! SQLiteRelationalDatabaseServiceContext
        return context[keyPath: keyPath]
    }

    init(
        config: ServiceConfig,
        pool: EventLoopGroupConnectionPool<SQLiteConnectionSource>
    ) {
        self.config = config
        self.pool = pool
    }

    public func connection() async throws -> SQLKit.SQLDatabase {
        pool.database(logger: self.logger).sql()
    }

}
