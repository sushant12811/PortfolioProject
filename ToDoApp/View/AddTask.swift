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
    @Binding  var editedDate : Date?

    
    let currentDate = Date()
    let futureDate = Calendar.current.date(from: DateComponents(year: 2030)) ?? Date()
    
    
    
    var body: some View {
        
        NavigationStack{
            VStack{
              
                DatePickerView()
                
                TextField("Add a Task", text: $textField)
                    .focused($isFocused)
                    .padding()
                    .background(.main.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.main.opacity(0.7), lineWidth: 1)
                            .padding()
                    }
                
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
                    selectedDate = taskToEdit.date ?? Date()
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
    
    //DatePicker
    private func DatePickerView() -> some View {
        DatePicker("Select a Date", selection: $selectedDate, in: currentDate...futureDate, displayedComponents: .date)
            .datePickerStyle(.compact)
            .padding()
            .background(.main.opacity(0.4))
            .clipShape(.rect(cornerRadius: 10))
            .padding()
        
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
                    vm.addTask(task: textField, date: selectedDate)
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
                .background(textField.isEmpty ? Color.main.opacity(0.6) : Color.main)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal)
                .shadow(color: Color.main.opacity(0.4), radius: 5)
        }
        
    }
    
   
}

#Preview {
    AddTask(taskToEdit: .constant(nil), editedDate: .constant(nil))
}
