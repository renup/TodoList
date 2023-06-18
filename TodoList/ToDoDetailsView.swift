//
//  ToDoDetailsView.swift
//  TodoList
//
//  Created by renupunjabi on 6/18/23.
//

import SwiftUI

struct ToDoDetailsView: View {
    let item: ToDo
    @ObservedObject var viewModel: TodoListViewModel
    @Binding var presentSheet: Bool
    
    var body: some View {
        VStack {
            Text(item.description)
            
            HStack(spacing: 10) {
                markAsCompletedButton(item)
                updateButton(item)
            }
        }
    }
    private func updateButton(_ item: ToDo) -> some View {
        Button("Update") {
            viewModel.selectedTodo = item
            viewModel.updateTodo = true
            presentSheet.toggle()
        }
        .padding()
        .background(.green)
        .cornerRadius(10)
    }
    
    private func markAsCompletedButton(_ item: ToDo) -> some View {
        Button {
            viewModel.selectedTodo = item
            viewModel.markComplete()
        } label: {
            Text("Mark Complete")
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 80, height: 50)
        .background(.green)
        .cornerRadius(10)
    }

}

struct ToDoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetailsView(item: ToDo.mock, viewModel: TodoListViewModel(), presentSheet: .constant(false))
    }
}
