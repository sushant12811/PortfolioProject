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


//MARK: Extension for CRUD
extension ToDoViewModel{
    
    //Fetch Task
    func fetchTask(){
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do{
            tasks = try persistentontainer.viewContext.fetch(fetchRequest)
        }catch let error {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    //Add Task
    func addTask(task : String){
        let newTask = Task(context: persistentontainer.viewContext)
        newTask.task = task
        save()
        fetchTask()
    }
    
    //Save Task
    func save(){
        let context = persistentontainer.viewContext
                if context.hasChanges {
                    do {
                        try context.save()
                        print("Successfully saved data")
                    } catch let error {
                        print("Failed to save data: \(error.localizedDescription)")
                    }
                }
    }
    
    //Delete Task
    func deleteTask(task : Task) {
        persistentontainer.viewContext.delete(task)
        save()
        fetchTask()
    }
    
//    func deleteTask(indexSet : IndexSet) {
//        guard let index = indexSet.first else {return}
//        let taskToDelete = tasks[index]
//        persistentontainer.viewContext.delete(taskToDelete)
//        save()
//    }
    
}
