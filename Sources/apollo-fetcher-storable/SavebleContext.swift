//
//  SavebleContext.swift
//  apollo-fetcherPackageDescription
//
//  Created by Evgeny Kalashnikov on 02.04.2018.
//  Copyright © 2018 Evgeny Kalashnikov. All rights reserved.
//

import Apollo
import SQLite

public protocol SavebleContext {
    var apollo: ApolloClient { get }
    var connection: Connection { get }
    init(apollo: ApolloClient, connection: Connection)
}
