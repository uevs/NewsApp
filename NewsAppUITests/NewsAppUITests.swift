//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by leonardo on 17/11/22.
//

import XCTest

final class NewsAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testDetailView() throws {
        /// Tests if a card can be opened and if there's correct information inside

        let app = XCUIApplication()
        app.launch()
        app.scrollViews.otherElements.staticTexts["Fully-configurable zero tolerance budgetary management"].tap()

        let author = app.scrollViews.otherElements.staticTexts["Author: dyakuntsov1d@mac.com"]
        let date = app.scrollViews.otherElements.staticTexts["Tue, Mar 10, '20"]

        XCTAssertTrue(author.exists)
        XCTAssertTrue(date.exists)
    }

    func testSwipeAndOpen() throws {
        /// Tests a sequence of swipes and then a card opening

        let app = XCUIApplication()
        app.launch()

        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.staticTexts["Fully-configurable zero tolerance budgetary management"].swipeUp()
        elementsQuery.staticTexts["Optional mobile contingency"].tap()

        let author = app.scrollViews.otherElements.staticTexts["Author: gleggis1a@rambler.ru"]
        let date = app.scrollViews.otherElements.staticTexts["Fri, Oct 25, '19"]

        XCTAssertTrue(author.exists)
        XCTAssertTrue(date.exists)
    }

    func testCardOpenAndClose() throws {
        /// Tests the opening and then closing of a card

        let app = XCUIApplication()
        app.launch()

        app.scrollViews.otherElements.staticTexts["Inverse asynchronous projection"].tap()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button)["x.circle.fill"].tap()

        let card = app.scrollViews.otherElements.staticTexts["Reactive well-modulated alliance"]

        XCTAssertTrue(card.exists)

    }
}
