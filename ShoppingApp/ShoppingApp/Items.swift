//
//  Item.swift
//  ShoppingApp
//
//  Created by Sushant Dhakal on 2025-05-12.
//

import Foundation
import SwiftData

@Model
final class Items {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
