//
//  SQLDatabaseContext.swift
//  FeatherComponentTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherComponent
import SQLiteKit

public struct SQLiteRelationalDatabaseComponentContext: ComponentContext {

    let eventLoopGroup: EventLoopGroup
    let connectionSource: SQLiteConnectionSource

    public init(
        eventLoopGroup: EventLoopGroup,
        connectionSource: SQLiteConnectionSource
    ) {
        self.eventLoopGroup = eventLoopGroup
        self.connectionSource = connectionSource
    }

    public func make() throws -> ComponentBuilder {
        SQLiteRelationalDatabaseComponentBuilder(context: self)
    }
}
