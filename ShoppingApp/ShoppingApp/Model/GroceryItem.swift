//
//  Items.swift
//  ShoppingApp
//
//  Created by Sushant Dhakal on 2025-05-12.
//
import Foundation
import SwiftData

@Model
class GroceryItem{
    var itemName: String
    var isPurchased: Bool
    var timeStamp: Date
    
    init(itemName: String, isPurchased: Bool, timeStamp: Date) {
        self.itemName = itemName
        self.isPurchased = isPurchased
        self.timeStamp = timeStamp
    }
}


