//
//  SQLDatabaseDriver.swift
//  FeatherComponentTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import AsyncKit
import FeatherComponent
import SQLiteKit

struct SQLiteRelationalDatabaseComponentFactory: ComponentFactory {

    let context: SQLiteRelationalDatabaseComponentContext

    func build(using config: ComponentConfig) throws -> Component {
        SQLiteRelationalDatabaseComponent(config: config)
    }
}
