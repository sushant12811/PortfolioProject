//
//  ContentView.swift
//  ToDoApp
//
//  Created by Sushant Dhakal on 2025-04-28.
//


import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject var viewModel: ToDoViewModel //Accessing the singleton via EnvironmentObject
    @EnvironmentObject var notificationCentre: NotificationCentre
    @State private var sheetPresentedOn = false
    @State private var editTask : Task?
    @State private var taskToDelete : Task?
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack{
            VStack{
                if viewModel.tasks.isEmpty {
                    Text("No tasks to show")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                List{
                    ForEach(viewModel.tasks, id: \.self){ task in
                        HStack{
                            Text(task.task ?? "")
                                .foregroundStyle(task.isCompleted ? .gray : .check)
                                .strikethrough(task.isCompleted ? true : false, color: .check.opacity(0.4))
                            Spacer()
                            if let date = task.date{
                                Text(date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
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
            .toolbar {
                trailingToolbarContent()

                }
        }
        .onAppear{
            viewModel.fetchTask()
            notificationCentre.notificationAuthorization() // requesting Noti
            UNUserNotificationCenter.current().setBadgeCount(0) //Making badge Disappear
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay (alignment: .bottom){
            addButtonTapped()
        }
        .sheet(isPresented: $sheetPresentedOn) {
            AddTask(taskToEdit: $editTask)
                .environmentObject(viewModel)
        }
        .alert("Delete", isPresented: $showAlert, actions:  {
            Button("Cancel", role: .cancel){
                //Cancel
            }
            Button("Ok", role: .destructive){
                if let task = taskToDelete{
                    viewModel.deleteTask(task: task )
                }
            
                viewModel.deleteAll()
                
            }
        }, message: {
            Text("Are you Sure want to delete?")
        })
        
        
        }
    }



//MARK: Extension for ContentView - Button, Images
extension TaskListView{
    
    //Add Task
    private func addButtonTapped() -> some View{
        Button{
            editTask = nil
            sheetPresentedOn = true
        }label: {
            Image(systemName: "plus")
                .padding()
                .background(.main)
                .clipShape(.circle)
                .foregroundStyle(.white)
                .shadow(color: .main.opacity(0.4), radius: 5)
        }
    }
    
    //CheckMarkImage
    private func checkmarkImage(task : Task) -> some View {
        Image(systemName: task.isCompleted ? "checkmark.circle.fill" :"circle")
            .foregroundStyle(.main)
            .imageScale(.large)
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.2)) {
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
            Button(role: .destructive){
                showAlert = true
                taskToDelete = task
            }label: {
                Label("Delete", systemImage: "trash")
            }
            
            
        }
    }
    
    @ToolbarContentBuilder
    private func trailingToolbarContent() -> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            Button("Clear All"){
                showAlert = true
            }
            .font(.headline)
            .padding()
            .clipShape(.rect(cornerRadius: 10))
            foregroundStyle(.accent)
        }
    }
    
}

#Preview {
    TaskListView()
        .environmentObject(ToDoViewModel.shared)
        .environmentObject(NotificationCentre.shared)
}
