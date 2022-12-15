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
        app.scrollViews.otherElements.staticTexts["Synergized leading edge interface"].tap()
        app.scrollViews.firstMatch.swipeUp()

        let author = app.scrollViews.otherElements.staticTexts["Author: Inesita Poyser"]

        XCTAssertTrue(author.exists)
    }

    func testSwipeAndOpen() throws {
        /// Tests a sequence of swipes and then a card opening

        let app = XCUIApplication()
        app.launch()

        app.scrollViews.firstMatch.swipeUp()
        app.scrollViews.otherElements.staticTexts["Innovative impactful artificial intelligence"].tap()
        app.scrollViews.firstMatch.swipeUp()
        let author = app.scrollViews.otherElements.staticTexts["Author: Patten Witling"]

        XCTAssertTrue(author.exists)
    }

    func testCardOpenAndClose() throws {
        /// Tests the opening and then closing of a card

        let app = XCUIApplication()
        app.launch()

        app.scrollViews.otherElements.staticTexts["Synergized leading edge interface"].tap()
        app.buttons["Close"].tap()

        
        app.scrollViews.firstMatch.swipeUp()

        let card = app.scrollViews.otherElements.staticTexts["Innovative impactful artificial intelligence"]

        XCTAssertTrue(card.exists)
    }
}
