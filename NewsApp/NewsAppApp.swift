//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

@main
struct NewsAppApp: App {
    @StateObject var data: DataStore = DataStore(NetworkManager())
    @StateObject var animations: AnimationStates = AnimationStates()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(data)
                .environmentObject(animations)
        }
    }
}
