//
//  QueryResult.swift
//  apollo-fetcher
//
//  Created by Evgeny Kalashnikov on 27.03.2018.
//

import Apollo

public class QueryResult<T> {
    var cancellable: Cancellable?
    private(set) var success = [((T) -> Void)]()
    private(set) var failure = [((QueryError) -> Void)]()
    
    private var data: T? {
        didSet {
            self.notifySuccess(data: self.data)
        }
    }
    
    private var error: QueryError? {
        didSet {
            self.notifyFailure(error: self.error)
        }
    }
    
    public init(data: T? = nil, error: QueryError? = nil) {
        if error == nil {
            self.data = data
        }
        self.error = error
    }
    
    func setup(data: T) {
        self.data = data
    }
    
    func setup(error: QueryError) {
        self.error = error
    }
    
    func notifySuccess(data: T?) {
        if let data = data {
            self.success.forEach { $0(data) }
            self.success.removeAll()
            self.failure.removeAll()
        }
    }
    
    func notifyFailure(error: QueryError?) {
        if let error = error {
            self.failure.forEach { $0(error) }
            self.failure.removeAll()
            self.success.removeAll()
        }
    }
    
    public func bindSuccess(_ result: @escaping (_ data: T) -> Void) {
        self.success.append(result)
        self.notifySuccess(data: self.data)
    }
    
    public func bindFailure(_ result: @escaping (_ error: QueryError) -> Void) {
        self.failure.append(result)
        self.notifyFailure(error: self.error)
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
