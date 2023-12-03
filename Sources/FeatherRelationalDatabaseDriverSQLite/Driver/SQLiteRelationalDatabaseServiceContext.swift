//
//  SQLDatabaseContext.swift
//  FeatherServiceTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherService
@preconcurrency import SQLiteKit

public struct SQLiteRelationalDatabaseServiceContext: ServiceContext {

    let eventLoopGroup: EventLoopGroup
    let connectionSource: SQLiteConnectionSource

    public init(
        eventLoopGroup: EventLoopGroup,
        connectionSource: SQLiteConnectionSource
    ) {
        self.eventLoopGroup = eventLoopGroup
        self.connectionSource = connectionSource
    }

    public func make() throws -> ServiceBuilder {
        SQLiteRelationalDatabaseServiceBuilder(context: self)
    }
}
