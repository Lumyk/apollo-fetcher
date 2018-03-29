//
//  Fetchable.swift
//  apollo-fetcher
//
//  Created by Evgeny Kalashnikov on 27.03.2018.
//

import Foundation
import Apollo
import apollo_mapper

public protocol Fetchable: Querible {
    associatedtype DefaultQuery: GraphQLQuery
    static func defaultQuery() -> DefaultQuery
    init(snapshot: Snapshot, storage: MapperStorage?, storeOnly: Bool) throws
}

public extension Fetchable {
    static func resultHandler(result: QueryResult<Self>, error: Error?, snapshot: Snapshot?, errors: [GraphQLError]?, storage: MapperStorage?) {
        if let error = error {
            result.setup(error: self.errorDecoder(error))
        } else if let snapshot = snapshot {
            do {
                result.setup(data: try Self(snapshot: snapshot, storage: storage, storeOnly: result.success == nil))
            } catch let error {
                result.setup(error: self.errorDecoder(error))
            }
        } else if let errors = errors {
            result.setup(error: self.errorsDecoder(errors))
        } else {
            result.setup(error: QueryError.unnown)
        }
    }
    
    @discardableResult
    public static func fetch(apollo: ApolloClient, storage: MapperStorage? = nil) -> QueryResult<Self> {
        return self.fetch(apollo: apollo, query: self.defaultQuery(), storage: storage)
    }
    
    @discardableResult
    public static func fetch<T: GraphQLQuery>(apollo: ApolloClient, query: T, storage: MapperStorage? = nil) -> QueryResult<Self> {
        let result = QueryResult<Self>()
        let queue = DispatchQueue.global(qos: .background)
        result.cancellable = apollo.fetch(query: query, cachePolicy: CachePolicy.fetchIgnoringCacheData, queue: queue) { (data, error) in
            self.resultHandler(result: result, error: error, snapshot: data?.data?.snapshot, errors: data?.errors, storage: storage)
        }
        return result
    }
}
