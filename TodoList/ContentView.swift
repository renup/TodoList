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
                        detailsView(item)
                    } label: {
                        todoCell(item)
                    }
                }
            }
            .navigationTitle("Todo's")
            .navigationBarItems(trailing: Button(action: {
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
    
    private func detailsView(_ item: ToDo) -> some View {
        VStack {
            Text(item.description)
            Button("Update") {
                viewModel.selectedTodo = item
                viewModel.updateTodo.toggle()
                presentSheet.toggle()
            }
            .padding()
            .background(.green)
            .cornerRadius(10)
                
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
