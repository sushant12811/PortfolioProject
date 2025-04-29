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
    @EnvironmentObject var nc : NotificationCentre

    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused : Bool
    @Binding var taskToEdit: Task?
    
    @State private var selectedDate = Date()
    let currentDate = Date()
    let futureDate = Calendar.current.date(from: DateComponents(year: 2030)) ?? Date()
    
    
    
    var body: some View {
        
        NavigationStack{
            VStack{
                
                DatePicker("Select a Date", selection: $selectedDate, in: currentDate...futureDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding()
                    .background(.gray.opacity(0.4))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
                
                TextField("Add a Task", text: $textField)
                    .focused($isFocused)
                    .padding()
                    .background(.green.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
                
                addEditButton()
                
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

//MARK: Extension: ADDTASk
extension AddTask{
    
    //ToolBar- Dismiss
    @ToolbarContentBuilder
    private func trailingToolBar()-> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            Button{
                dismiss()
            }label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .tint(.secondary)
            }
            
        }
        
    }
    
    //Add/Update Button
    private func addEditButton()-> some View {
        Button{
            if !textField.isEmpty {
                if let taskToEdit = taskToEdit {
                    // Update existing task
                    vm.updateTask(task: taskToEdit, newTitle: textField, date: selectedDate)
                } else {
                    // Add new task
                    vm.addTask(task: textField)
                    nc.scheduleNotification(taskTitle: textField, taskDate: selectedDate)
                    
                }
                dismiss()
            } else {
                isFocused = true
            }
            
            
        }label: {
            Text(taskToEdit == nil ? "Save" : "Update")
                .font(.title3.bold())
                .tint(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(textField.isEmpty ? Color.green.opacity(0.6) : Color.green)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal)
                .shadow(color: Color.green.opacity(0.4), radius: 5)
        }
        
    }
}

#Preview {
    AddTask(taskToEdit: .constant(nil))
        .preferredColorScheme(.dark)
}
