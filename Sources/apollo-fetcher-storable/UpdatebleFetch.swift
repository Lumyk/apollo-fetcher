//
//  UpdatebleFetch.swift
//  apollo-fetcher-storable
//
//  Created by Evgeny Kalashnikov on 18.04.2018.
//

import Foundation
import Apollo
import apollo_fetcher
import apollo_mapper
import sqlite_helper

public protocol UpdatebleFetch: StorableFetch {
    static func updateQuery(storage: Storege) -> DefaultQuery
}

public extension UpdatebleFetch {
    
    public static func fetchAndSave(context: SavebleContext, storeOnly: Bool = false, update: Bool, transactionSplitter: MapperStorageTransactionSplitter = .one) -> QueryResult<Self> {
        let types = Self.storageTypes()
        let storage = Storege(connection: context.connection, types: types, splitter: transactionSplitter)
        let query = update ? Self.updateQuery(storage: storage) : Self.defaultQuery()
        return self.fetch(apollo: context.apollo, query: query, storage: storage, storeOnly: storeOnly)
    }
}
