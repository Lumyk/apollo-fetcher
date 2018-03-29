import XCTest
import Apollo
import apollo_mapper

@testable import apollo_fetcher

class apollo_fetcherTests: XCTestCase {
    
    enum QueryErrorTest: Error {
        case testError1
        case testError2
        case testError3
    }
    
    class CancelResult: Cancellable {
        func cancel() {
            XCTAssert(true)
        }
    }
    
    class QueribleTestClass: Querible { }
    
    class PerformableTestClass: Performable {
        required init(data: SignInMutation.Data?) throws {
            
        }
    }
    
    class PerformableTestClassBroken: Performable {
        required init(data: SignInMutation.Data?) throws {
            throw QueryErrorTest.testError2
        }
    }
    
    class FetchableTestClass: Fetchable {
        static func defaultQuery() -> CarsQuery {
            return CarsQuery(limit: 10)
        }
        
        required init(snapshot: Snapshot, storage: MapperStorage?, storeOnly: Bool) throws {
            
        }
    }
    
    class FetchableTestClassBroken: Fetchable {
        static func defaultQuery() -> CarsQuery {
            return CarsQuery(limit: 10)
        }
        
        required init(snapshot: Snapshot, storage: MapperStorage?, storeOnly: Bool) throws {
            throw QueryErrorTest.testError1
        }
    }
    
    func testQueryResult() {
        let result = QueryResult<Int>()
        result.bindSuccess { (value) in
            XCTAssert(value == 10, "testQueryResult error 1")
        }
        result.setup(data: 10)
        
        result.bindFailure { (error) in
            XCTAssert(error.localizedDescription == QueryError.unnown.localizedDescription, "testQueryResult error 2")
        }
        result.setup(error: QueryError.unnown)
        
        result.cancel()
        
        let result2 = QueryResult<Int>(data: 11, error: QueryError.unnown)
        
        result2.bindSuccess { (value) in
            XCTFail("testQueryResult error 3")
        }
        
        result2.bindFailure { (error) in
            XCTAssert(error.localizedDescription == QueryError.unnown.localizedDescription, "testQueryResult error 4")
        }
        
        let result3 = QueryResult<Int>(data: 12)
        result3.bindSuccess { (value) in
            XCTAssert(value == 12, "testQueryResult error 5")
        }
        result3.cancellable = CancelResult()
        
        XCTAssert(result3.cancel(), "testQueryResult error 6")
    }

    func testQuerible() {
        let error = QueribleTestClass.errorDecoder(QueryErrorTest.testError1)
        XCTAssert(error.localizedDescription == QueryError.another(error: QueryErrorTest.testError1).localizedDescription, "testQuerible error 1")
        
        let error2 = QueribleTestClass.errorsDecoder([])
        XCTAssert(error2.localizedDescription == QueryError.unnown.localizedDescription, "testQuerible error 2")
    }
    
    func testPerformableResultHandler() {
        let result = QueryResult<PerformableTestClass>()
        result.bindFailure { (error) in
            switch error {
                case .another(error: let error):
                    XCTAssert(error.localizedDescription == QueryErrorTest.testError3.localizedDescription, "testPerformableResultHandler error 1")
            case .unnown:
                XCTFail()
            }
        }
        let data: SignInMutation.Data? = nil
        PerformableTestClass.resultHandler(result: result, error: QueryErrorTest.testError3, data: data, errors: nil)
        
        let result1 = QueryResult<PerformableTestClass>()
        result1.bindFailure { (error) in
            switch error {
            case .another(error: let error):
                XCTFail("testPerformableResultHandler error 2 \(error)")
            case .unnown:
                XCTAssert(true)

            }
        }
        PerformableTestClass.resultHandler(result: result1, error: nil, data: data, errors: nil)
        
        PerformableTestClass.resultHandler(result: result1, error: nil, data: data, errors: [])
        
        let result2 = QueryResult<PerformableTestClass>()
        result2.bindSuccess { (result) in
            XCTAssert(true)
        }
        result2.bindFailure { (_) in
            XCTFail("testPerformableResultHandler error 3")
        }
        PerformableTestClass.resultHandler(result: result2, error: nil, data: SignInMutation.Data(snapshot: [:]), errors: nil)
        
        
        let result3 = QueryResult<PerformableTestClassBroken>()
        result3.bindSuccess { (result) in
            XCTFail("testPerformableResultHandler error 3")
        }
        result3.bindFailure { (_) in
            XCTAssert(true)
        }
        PerformableTestClassBroken.resultHandler(result: result3, error: nil, data: SignInMutation.Data(snapshot: [:]), errors: nil)
        
    }
    
    func testFetchableResultHandler() {
        let result = QueryResult<FetchableTestClass>()
        result.bindFailure { (error) in
            switch error {
            case .another(error: let error):
                XCTAssert(error.localizedDescription == QueryErrorTest.testError3.localizedDescription, "testFetchableResultHandler error 1")
            case .unnown:
                XCTFail()
            }
        }
        FetchableTestClass.resultHandler(result: result, error: QueryErrorTest.testError3, snapshot: nil, errors: nil, storage: nil)
        
        
        let result1 = QueryResult<FetchableTestClass>()
        result1.bindFailure { (error) in
            switch error {
            case .another(error: let error):
                XCTFail("testPerformableResultHandler error 2 \(error)")
            case .unnown:
                XCTAssert(true)
                
            }
        }
        FetchableTestClass.resultHandler(result: result1, error: nil, snapshot: nil, errors: nil, storage: nil)
        
        FetchableTestClass.resultHandler(result: result1, error: nil, snapshot: nil, errors: [], storage: nil)
        
        let result2 = QueryResult<FetchableTestClass>()
        result2.bindSuccess { (result) in
            XCTAssert(true)
        }
        result2.bindFailure { (_) in
            XCTFail("testPerformableResultHandler error 3")
        }
        
        FetchableTestClass.resultHandler(result: result1, error: nil, snapshot: [:], errors: nil, storage: nil)

        let result3 = QueryResult<FetchableTestClassBroken>()
        result3.bindSuccess { (result) in
            XCTFail("testPerformableResultHandler error 3")
        }
        result3.bindFailure { (_) in
            XCTAssert(true)
        }
        
        FetchableTestClassBroken.resultHandler(result: result3, error: nil, snapshot: [:], errors: nil, storage: nil)
    }
    
    func testPerformablePerform() {
        let apollo = ApolloClient(url: URL(string: "http://localhost")!)
        let semaphore = DispatchSemaphore(value: 0)
        
        let result = PerformableTestClass.perform(apollo: apollo, mutation: SignInMutation(email: "", password: ""))
        result.bindFailure { (_) in
            XCTAssert(true)
            semaphore.signal()
        }
        result.bindSuccess { (_) in
            XCTFail("testPerformablePerform error 1")
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    func testFetchableFetch() {
        let apollo = ApolloClient(url: URL(string: "http://localhost")!)
        let semaphore = DispatchSemaphore(value: 0)
        
        let result = FetchableTestClass.fetch(apollo: apollo, query: CarsQuery(limit: 10), storage: nil)
        result.bindFailure { (_) in
            XCTAssert(true)
            semaphore.signal()
        }
        result.bindSuccess { (_) in
            XCTFail("testFetchableFetch error 1")
            semaphore.signal()
        }
        semaphore.wait()
        
        let result2 = FetchableTestClass.fetch(apollo: apollo)
        result2.bindFailure { (_) in
            XCTAssert(true)
            semaphore.signal()
        }
        result2.bindSuccess { (_) in
            XCTFail("testFetchableFetch error 2")
            semaphore.signal()
        }
        semaphore.wait()
    }

    static var allTests = [
        ("testQueryResult", testQueryResult),
        ("testQuerible", testQuerible),
        ("testPerformableResultHandler", testPerformableResultHandler),
        ("testFetchableResultHandler", testFetchableResultHandler),
        ("testPerformablePerform", testPerformablePerform),
        ("testFetchableFetch", testFetchableFetch),
    ]
}
