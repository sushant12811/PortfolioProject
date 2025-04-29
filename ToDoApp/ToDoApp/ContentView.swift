//
//  ContentView.swift
//  ToDoApp
//
//  Created by Sushant Dhakal on 2025-04-28.
//


import SwiftUI

struct ContentView: View {
    
    //    @Environment(\.managedObjectContext) var viewContext // accessing the DB using context
    @EnvironmentObject var viewModel: ToDoViewModel //Accessing the singleton via EnvironmentObject
    @State private var sheetPresentedOn = false
    @State private var isCheckmark = false
    @State private var editTask : Task?
    
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(viewModel.tasks, id: \.self){ task in
                        HStack{
                            Text(task.task ?? "")
                            Spacer()
                            checkmarkImage(task: task)
                        }
                        .contextMenu{
                            contextMenuItem(task : task)
                        }
                        
                    }
                    
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Task")
        }
        .onAppear{
            viewModel.fetchTask()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay (alignment: .bottom){
            addButtonTapped()
        }
        .sheet(isPresented: $sheetPresentedOn) {
            AddTask(taskToEdit: editTask)
                .environmentObject(viewModel)
        }
    }
}


//MARK: Extension for ContentView - Button, Images
extension ContentView{
    
    //Add Task
    private func addButtonTapped() -> some View{
        Button{
            sheetPresentedOn = true
            editTask = nil
        }label: {
            Image(systemName: "plus")
                .padding()
                .background(.green)
                .clipShape(.circle)
                .foregroundStyle(.white)
        }
    }

    //CheckMarkImage
    private func checkmarkImage(task : Task) -> some View {
        Image(systemName: task.isCompleted ? "checkmark.circle.fill" :"circle")
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.4)) {
                    viewModel.toggleTaskCompletion(task: task)
                }
            }
    }
    
    
    //Context Menu: Delete and Edit
    private func contextMenuItem(task : Task) -> some View {
        VStack {
            //Edit
            Button{
                editTask = task
                sheetPresentedOn = true
            }label:{
                Label("Edit", systemImage: "pencil")
            }
            
            //Delete
            Button(role : .destructive){
                viewModel.deleteTask(task: task)
            }label:{
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ToDoViewModel.shared)
}
