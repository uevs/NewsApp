//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by leonardo on 17/11/22.
//

import XCTest
@testable import NewsApp

final class NewsAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testComputedProperties() throws {
        let news: News = News(id: 01, title: "Test", description: "Lorem Ipsum", release_date: "02/03/2022", author: "Steve J.", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff")

        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        let testDate = formatter.date(from: "02/03/2022")

        XCTAssertTrue(news.date == testDate, "Computed property 'date' returns wrong value")

        XCTAssertTrue(news.date != .distantPast, "Couldn't unwrap release_date")

        XCTAssertTrue(news.formattedDate == "Thu, Feb 3, '22", "Computed property 'formattedDate' returns wrong value")

        XCTAssertTrue(news.imageURL != URL(string: "https://dummyimage.com/600"), "Couldn't unwrap the image url")

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
