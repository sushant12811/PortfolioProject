//
//  AddTask.swift
//  ToDoApp
//
//  Created by Sushant Dhakal on 2025-04-28.
//

import SwiftUI

struct AddTask: View {
    
    @State private var textField: String = ""
    
    var body: some View {
        VStack{
            TextField("Add a Task", text: $textField)
                .padding()
                .background(.green.opacity(0.2))
                .clipShape(.rect(cornerRadius: 10))
                .padding()
            
            Button("Save"){
                //Save Action
            }
            .font(.title3.bold())
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.green)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal)
            .shadow(color: Color.green.opacity(0.4), radius: 5)
        }
    }
}

#Preview {
    AddTask()
}
