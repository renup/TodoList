//
//  AddItemView.swift
//  TodoList
//
//  Created by renupunjabi on 6/17/23.
//

import SwiftUI

struct AddUpdateItemView: View {
    
    @State var title: String = ""
    @State var description: String = ""
    @Binding var presentSheet: Bool
    
    @ObservedObject var viewModel: TodoListViewModel
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
            TextField("Description", text: $description)
            
            Spacer()
            addUpdateButton
        }
        .padding()
    }
    
    private var addUpdateButton: some View {
        Button {
            // save to viewModel
            if viewModel.updateTodo {
                viewModel.updateSelectedTodo(title: title, description: description)
            } else {
                viewModel.addTodo(ToDo(title: title, description: description))
            }
            presentSheet.toggle()
        } label: {
            Text(viewModel.updateTodo ? "Update" : "Add")
        }
        .padding()
        .frame(width: 80, height: 50)
        .background(.green)
        .cornerRadius(10)
    }
}

//struct AddItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemView(presentSheet: <#Binding<Bool>#>, viewModel: <#TodoListViewModel#>)
//    }
//}
