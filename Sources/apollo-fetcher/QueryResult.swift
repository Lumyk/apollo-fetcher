//
//  QueryResult.swift
//  apollo-fetcher
//
//  Created by Evgeny Kalashnikov on 27.03.2018.
//

import Apollo

public class QueryResult<T> {
    var cancellable: Cancellable?
    private(set) var success: ((T) -> Void)?
    private(set) var failure: ((QueryError) -> Void)?
    
    private var data: T? {
        didSet {
            if let data = self.data {
                self.success?(data)
            }
        }
    }
    
    private var error: QueryError? {
        didSet {
            if let error = self.error {
                self.failure?(error)
            }
        }
    }
    
    public init(data: T? = nil, error: QueryError? = nil) {
        if let data = data, error == nil {
            self.data = data
        } else if let error = error {
            self.error = error
        }
    }
    
    func setup(data: T) {
        self.data = data
    }
    
    func setup(error: QueryError) {
        self.error = error
    }
    
    public func bindSuccess(_ result: @escaping (_ data: T) -> Void) {
        self.success = result
        if let data = self.data {
            self.success?(data)
        }
    }
    
    public func bindFailure(_ result: @escaping (_ error: QueryError) -> Void) {
        self.failure = result
        if let error = self.error {
            self.failure?(error)
        }
    }
    
    @discardableResult
    public func cancel() -> Bool {
        if let cancellable = self.cancellable {
            cancellable.cancel()
            return true
        }
        return false
    }
}
