//
//  Performable.swift
//  apollo-fetcher
//
//  Created by Evgeny Kalashnikov on 27.03.2018.
//

import Foundation
import Apollo

public protocol Performable: Querible {
    associatedtype MutationData: GraphQLSelectionSet
    init(data: MutationData?) throws
}

public extension Performable {
    static func resultHandler(result: QueryResult<Self>, error: Error?, data: MutationData?, errors: [GraphQLError]?) {
        if let error = error {
            result.setup(error: self.errorDecoder(error))
        } else if let data = data {
            do {
                result.setup(data: try Self(data: data))
            } catch let error {
                result.setup(error: self.errorDecoder(error))
            }
        } else if let errors = errors {
            result.setup(error: self.errorsDecoder(errors))
        } else {
            result.setup(error: QueryError.unnown)
        }
    }
    
    public static func perform<T: GraphQLMutation>(apollo: ApolloClient, mutation: T) -> QueryResult<Self> {
        let result = QueryResult<Self>()
        let queue = DispatchQueue.global(qos: .background)
        result.cancellable = apollo.perform(mutation: mutation, queue: queue, resultHandler: { (data, error) in
            self.resultHandler(result: result, error: error, data: data?.data as? MutationData, errors: data?.errors)
        })
        return result
    }
}
