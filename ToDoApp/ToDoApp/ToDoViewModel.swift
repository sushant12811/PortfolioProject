//
//  ViewModel.swift
//  ToDoApp
//
//  Created by Sushant Dhakal on 2025-04-28.
//

import Foundation
import CoreData

class ToDoViewModel: ObservableObject {
    @Published var tasks : [Task] = []
    
    static let shared = ToDoViewModel() // Singleton (global instance) -> will be only one instance of this ViewModel throughout the app.
    
    lazy var persistentontainer : NSPersistentContainer = { //lazy: persistentContainer holds database, but it's only created when first needed.
        let container = NSPersistentContainer(name: "Model")// coreData helper object : manages the database (saving, loading,etc)
        
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading persistent stores: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    private init(){} //no one create an another instance, forces the app to use singleton instead
}


extension ToDoViewModel{
    
    func fetchTask(){
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do{
            tasks = try persistentontainer.viewContext.fetch(fetchRequest)
        }catch let error {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    func addTask(task : String){
        let newTask = Task(context: persistentontainer.viewContext)
        newTask.task = task
        save()
    }
    
    func save(){
        guard persistentontainer.viewContext.hasChanges else {return}
        do{
            try persistentontainer.viewContext.save()
        }catch {
            print("Faile to Save Data: \(error.localizedDescription)")
            
        }
    }
    
    func deleteTask(task : Task) {
        persistentontainer.viewContext.delete(task)
        save()
    }
    
}
