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
    static func updateQuery() -> DefaultQuery
}

public extension UpdatebleFetch {
    public static func fetchAndSave(context: SavebleContext, storeOnly: Bool = false, update: Bool) -> QueryResult<Self> {
        let query = update ? Self.updateQuery() : Self.defaultQuery()
        return self.fetchAndSave(context: context, query: query, storeOnly: storeOnly)
    }
}
