//
//  ShoppingAppApp.swift
//  ShoppingApp
//
//  Created by Sushant Dhakal on 2025-05-12.
//

import SwiftUI
import SwiftData

@main
struct ShoppingAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([GroceryItem.self])
        let config = ModelConfiguration("ShoppingModel", schema: schema)
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ShoppingListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
