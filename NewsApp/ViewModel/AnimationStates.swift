//
//  AnimationStates.swift
//  NewsApp
//
//  Created by leonardo on 21/11/22.
//

import Foundation

/// Stores the state used to handle animations on different views.
///
class AnimationStates: ObservableObject {
    @Published var isExpanded: Bool = false
    @Published var showDetail: Bool = false
}
