//
//  DataStore.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import Foundation

class DataStore: ObservableObject {
    var news: [News] = [News(id: 01, title: "Lorem1", description: "1Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/01/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff"),
                        News(id: 02, title: "Lorem2", description: "2Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/02/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff"),
                        News(id: 03, title: "Lorem3", description: "3Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/03/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff"),
                        News(id: 04, title: "Lorem4", description: "4Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/04/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff"),
                        News(id: 05, title: "Lorem5", description: "5Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/05/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff"),
                        News(id: 06, title: "Lorem6", description: "6Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/06/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff"),
                        News(id: 07, title: "Lorem7", description: "7Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/07/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff"),
                        News(id: 08, title: "Lorem8", description: "8Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/08/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff"),
                        News(id: 09, title: "Lorem9", description: "9Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/09/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff"),
                        News(id: 10, title: "Lorem10", description: "10Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", release_date: "10/010/2020", author: "J Doe", image: "https://dummyimage.com/366x582.png/5fa2dd/ffffff")]
    

}
