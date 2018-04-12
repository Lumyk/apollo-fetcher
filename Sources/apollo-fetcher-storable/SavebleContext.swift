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
    init(apollo: ApolloClient, connection: Connection)
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
    
    public static func fetchAndSave(context: SavebleContext, storeOnly: Bool = false) -> QueryResult<Self> {
        let types = Self.storageTypes()
        let storage = Storege(connection: context.connection, types: types)
        return self.fetch(apollo: context.apollo, storage: storage, storeOnly: storeOnly)
    }
    
    public static func fetchAndSave<T: GraphQLQuery>(context: SavebleContext, query: T, storeOnly: Bool = false) -> QueryResult<Self> {
        let types = Self.storageTypes()
        let storage = Storege(connection: context.connection, types: types)
        return self.fetch(apollo: context.apollo, query: query, storage: storage, storeOnly: storeOnly)
    }
}
