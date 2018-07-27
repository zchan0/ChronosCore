import XCTest
import ChronosCore

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfMidnights() {
        if let startDate = Date.dateFromString("2010-01-14 23:30"),
            let endDate = Date.dateFromString("2010-01-15 08:00") {
            XCTAssertEqual(Calendar.current.numberOfMidnights(ofStartDate: startDate, endDate), 1)
        }
    }
    
    func testNumberOfDays() {
        if let startDate = Date.dateFromString("2018-07-23 18:42"),
            let endDate = Date.dateFromString("2018-07-23 23:59") {
            XCTAssertEqual(Calendar.current.numberOfMidnights(ofStartDate: startDate, endDate), 0)
        }
    }
    
    func testIsDateThisWeek() {
        if let date = Date.dateFromString("2018-07-21", withFormatter: "yyyy-MM-dd") {
            XCTAssertEqual(Calendar.current.isDateInWeek(date), false)
        }
    }
    
    func testBeginningOfWeek() {
        if let beginningDate = Calendar.current.beginningOfWeek() {
            let beginning: String = Date.stringFromDate(beginningDate)
            XCTAssertEqual(beginning, "2018-07-22")
        }
    }
    
}
