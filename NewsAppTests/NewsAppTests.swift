//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by leonardo on 17/11/22.
//

import XCTest
import Combine
@testable import NewsApp

final class NewsAppTests: XCTestCase {

//    override func setUpWithError() throws {
//    }

//    override func tearDownWithError() throws {
//
//    }

    func testModelComputedProperties() throws {
        /// Tests the computed properties of the data model

        let news: News = News(id: 01, title: "Test", description: "Lorem Ipsum", release_date: "02/03/2022", author: "Steve J.", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff")

        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        let testDate = formatter.date(from: "02/03/2022")

        XCTAssertTrue(news.date == testDate, "Computed property 'date' returns wrong value")

        XCTAssertTrue(news.date != .distantPast, "Couldn't unwrap release_date")

        XCTAssertTrue(news.formattedDate == "Thu, Feb 3, '22", "Computed property 'formattedDate' returns wrong value")

        XCTAssertTrue(news.imageURL != URL(string: "https://dummyimage.com/600"), "Couldn't unwrap the image url")
    }
    
    func testNetworkManager() throws {
        /// Tests if the Network Manager can get data from the api
    
        let url = URL(string: "https://run.mocky.io/v3/de42e6d9-2d03-40e2-a426-8953c7c94fb8")!
        var result: [News] = []
        var cancellables = Set<AnyCancellable>()
        let expectation = self.expectation(description: "received")

        
        NetworkManager.getData(url: url)
            .decode(type: [News].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { (articles) in
                result = articles
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        XCTAssertTrue(!result.isEmpty, "NetworkManager published an empty array.")
    }
    
    
    func testImageLoader() throws {
        /// Tests if the ImageLoader publishes and image
        
        let imageLoader = ImageLoader(url: URL(string: "https://dummyimage.com/367x809.png/ff4444/ffffff")!, id: 17)
        let expectation = self.expectation(description: "received")
        var image: UIImage?

        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            if let loadedImage = imageLoader.image {
                image = loadedImage
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5)
        XCTAssertTrue(image != nil, "ImageLoader didn't publish an image")
        
        let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("images").appendingPathComponent("17.png")
        try FileManager.default.removeItem(atPath: url!.path)
    }
    
    
    func testViewModel() throws {
        /// Tests if the view models correctly fetches data from the internet
        
        let viewModel = DataStore()
        let testNews = News(id: 17, title: "Decentralized transitional moderator", description: "non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat", release_date: "5/25/2018", author: "kpittmang@behance.net", image: "http://dummyimage.com/367x809.png/ff4444/ffffff")
    
        XCTAssertTrue(!viewModel.news.isEmpty, "News array is empty")
        XCTAssertTrue(viewModel.news.first!.date > viewModel.news.last!.date, "News are not sorted by date")
        XCTAssertTrue(viewModel.news.first(where: { $0.id == 17 }) == testNews, "Incorrect News at id 17")
    }
    

}
