//
//  AnimationsManager.swift
//  NewsApp
//
//  Created by leonardo on 21/11/22.
//

import Foundation

class AnimationManager: ObservableObject {
    @Published var isExpanded: Bool = false
    @Published var id: Int = 0
}
