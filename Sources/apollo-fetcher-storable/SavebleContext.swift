//
//  SavebleContext.swift
//  CropioTelematics
//
//  Created by Evgeny Kalashnikov on 02.04.2018.
//  Copyright © 2018 Evgeny Kalashnikov. All rights reserved.
//

import Foundation
import Apollo
import SQLite
import apollo_fetcher
import apollo_mapper
import sqlite_helper

public protocol SavebleContext {
    var apollo: ApolloClient { get }
    var connection: Connection { get }
    init(apollo: ApolloClient, connection: Connection) throws
}

public protocol StorableFetch {
    static func storageTypes() -> [Storable.Type]
}

public extension StorableFetch where Self: Fetchable {
    
    public static func fetch(context: SavebleContext) -> QueryResult<Self> {
        return self.fetch(apollo: context.apollo, storage: nil)
    }
    
    public static func fetch<T: GraphQLQuery>(context: SavebleContext, query: T) -> QueryResult<Self> {
        return self.fetch(apollo: context.apollo, query: query, storage: nil)
    }
    
    public static func fetchAndSave(context: SavebleContext) throws -> QueryResult<Self> {
        let types = Self.storageTypes()
        let storage = Storege(connection: context.connection, types: types)
        return self.fetch(apollo: context.apollo, storage: storage)
    }
    
    public static func fetchAndSave<T: GraphQLQuery>(context: SavebleContext, query: T) throws -> QueryResult<Self> {
        let types = Self.storageTypes()
        let storage = Storege(connection: context.connection, types: types)
        return self.fetch(apollo: context.apollo, query: query, storage: storage)
    }
}
