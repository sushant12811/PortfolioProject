//
//  AddTask.swift
//  ToDoApp
//
//  Created by Sushant Dhakal on 2025-04-28.
//

import SwiftUI

struct AddTask: View {
    
    @State private var textField: String = ""
    @EnvironmentObject var vm : ToDoViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused : Bool
    var taskToEdit: Task?
    
    
    
    var body: some View {
        
        NavigationStack{
            VStack{
                TextField("Add a Task", text: $textField)
                    .focused($isFocused)
                    .padding()
                    .background(.green.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
                
                Button{
                    if !textField.isEmpty {
                        if let taskToEdit = taskToEdit {
                            // Update existing task
                            vm.updateTask(task: taskToEdit, newTitle: textField)
                        } else {
                            // Add new task
                            vm.addTask(task: textField)
                        }
                        dismiss()
                    } else {
                        isFocused = true
                    }
                    
                    
                }label: {
                    Text(taskToEdit == nil ? "Save" : "Update")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(textField.isEmpty ? Color.green.opacity(0.6) : Color.green)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.horizontal)
                        .shadow(color: Color.green.opacity(0.4), radius: 5)
                }
                
                Spacer()
            }
            .toolbar {
                trailingToolBar()
            }
            .onAppear{
                isFocused = true
                if let taskToEdit = taskToEdit {
                    textField = taskToEdit.task ?? ""
                }
            }
            .navigationTitle(taskToEdit == nil ? "Add Task" : "Edit Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension AddTask{
    
    @ToolbarContentBuilder
    private func trailingToolBar()-> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            Button{
                dismiss()
            }label: {
                Image(systemName: "clear")
            }
            
        }
        
    }
}

#Preview {
    AddTask()
}
