//
//  ContentView.swift
//  ToDoApp
//
//  Created by Sushant Dhakal on 2025-04-28.
//


import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext // accessing the DB using context
    @EnvironmentObject var viewModel: ToDoViewModel //Accessing the singleton via EnvironmentObject
    @State private var sheetPresentedOn = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(viewModel.tasks, id: \.self){ task in
                        HStack{
                            Text(task.task ?? "")
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                        }
                            .contextMenu {
                                Button(role: .destructive) {
                                    viewModel.deleteTask(task: task)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        
                    }
                    
                }
                
                
                
            }
        }
            .onAppear{
                viewModel.fetchTask()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay (alignment: .bottom){
                Button{
                    //Action
                    sheetPresentedOn = true
                    
                }label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(.green)
                        .clipShape(.circle)
                        .foregroundStyle(.white)
                }
            }
            .sheet(isPresented: $sheetPresentedOn) {
                AddTask()
            }
            .navigationTitle("Task")
        }
        
    
}

#Preview {
    ContentView()
        .environmentObject(ToDoViewModel.shared)
}
