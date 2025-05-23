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
    @StateObject private var notificationCentre = NotificationCentre.shared
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environmentObject(viewModel)
                .environmentObject(notificationCentre)
            
        }
    }
}

//   .environment(\.managedObjectContext, viewModel.persistentontainer.viewContext) // Inject the persistent container's managed object context into the environment if we need to access the Environment(\.managedObject) any other View hierarchy(like in other views)

