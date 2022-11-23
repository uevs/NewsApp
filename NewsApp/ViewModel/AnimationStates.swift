//
//  AnimationStates.swift
//  NewsApp
//
//  Created by leonardo on 21/11/22.
//

import Foundation

class AnimationStates: ObservableObject {
    @Published var isExpanded: Bool = false
    @Published var showDetail: Bool = false
    @Published var scaleEffect: Double = 10
    @Published var opacity: Double = 1
}
