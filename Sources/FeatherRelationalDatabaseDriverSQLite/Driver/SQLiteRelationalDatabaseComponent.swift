//
//  File 2.swift
//
//
//  Created by Tibor Bodecs on 03/12/2023.
//

import FeatherComponent
import FeatherRelationalDatabase
import SQLKit

@dynamicMemberLookup
struct SQLiteRelationalDatabaseComponent: RelationalDatabaseComponent {

    public let config: ComponentConfig

    subscript<T>(
        dynamicMember keyPath: KeyPath<
            SQLiteRelationalDatabaseComponentContext, T
        >
    ) -> T {
        let context =
            config.context as! SQLiteRelationalDatabaseComponentContext
        return context[keyPath: keyPath]
    }

    public func connection() async throws -> SQLKit.SQLDatabase {
        self.pool.database(logger: self.logger).sql()
    }
}
