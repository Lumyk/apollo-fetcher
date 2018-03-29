//
//  Querible.swift
//  apollo-fetcher
//
//  Created by Evgeny Kalashnikov on 27.03.2018.
//

import Apollo

public protocol Querible {
    static func errorDecoder(_ error: Error) -> QueryError
    static func errorsDecoder(_ errors: [GraphQLError]) -> QueryError
}

extension Querible {
    static func errorDecoder(_ error: Error) -> QueryError {
        return QueryError.another(error: error)
    }
    
    static func errorsDecoder(_ errors: [GraphQLError]) -> QueryError {
        return QueryError.unnown
    }
}
