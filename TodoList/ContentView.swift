//
//  ContentView.swift
//  TodoList
//
//  Created by renupunjabi on 6/17/23.
//

import SwiftUI

// Update
// mark as complete (change the datasource, add a ui element- eg: a green checkmark - use SFSymbols)
// delete a todo
struct ContentView: View {
    
    @StateObject var viewModel = TodoListViewModel()
    @State var presentSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.todos) { item in
                    NavigationLink {
                        ToDoDetailsView(item: item, viewModel: viewModel, presentSheet: $presentSheet)
                    } label: {
                        todoCell(item)
                    }
                }
            }
            .navigationTitle("Todo's")
            .navigationBarItems(trailing: Button(action: {
                viewModel.updateTodo = false
                presentSheet.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            
            .sheet(isPresented: $presentSheet) {
                AddUpdateItemView(presentSheet: $presentSheet, viewModel: viewModel)
            }
        }
    }
    
    private func todoCell(_ item: ToDo) -> some View {
        HStack {
            ZStack {
                Color(item.completed ? .green : .red)
            }
            .frame(width: 15, height: 15)
            .clipShape(Circle())
            
            Text(item.title)
            
            Spacer()
            ZStack {
                Rectangle()
                    .frame(width: 70, height: 30)
                    .cornerRadius(10)
                    .padding()
                    .foregroundColor(.red)
                    .onTapGesture {
                        viewModel.delete(item)
                    }
                Text("Delete")
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
