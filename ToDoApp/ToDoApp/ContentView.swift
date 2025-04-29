//
//  ContentView.swift
//  ToDoApp
//
//  Created by Sushant Dhakal on 2025-04-28.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
            VStack{
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay (alignment: .bottom){
                Button{
                    //Action
                }label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(.green)
                        .clipShape(.circle)
                        .foregroundStyle(.white)
                }
            }
        }
    
}

#Preview {
    ContentView()
}
