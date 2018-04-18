//
//  StorableFetch.swift
//  apollo-fetcherPackageDescription
//
//  Created by Evgeny Kalashnikov on 18.04.2018.
//

import Foundation
import Apollo
import apollo_fetcher
import apollo_mapper
import sqlite_helper

public protocol StorableFetch: Fetchable {
    static func storageTypes() -> [Storable.Type]
}

public extension StorableFetch {
    
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
