//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Sushant Dhakal on 2025-04-28.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    
    @StateObject private var viewModel = ToDoViewModel.shared // Observable Instance
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewModel.persistentontainer.viewContext) // Inject the persistent container's managed object context into the environment.
            
        }
    }
}
