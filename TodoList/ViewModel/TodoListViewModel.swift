//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by renupunjabi on 6/17/23.
//

import Foundation
import Combine

struct ToDo: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var completed: Bool = false
    
    mutating func update(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    static let mock = ToDo(title: "first todo", description: "first todo description")
}

class TodoListViewModel: ObservableObject {
    
    @Published var todos = [ToDo]()
    var updateTodo = false
    var selectedTodo: ToDo?
    
    func addTodo(_ todo: ToDo) {
        todos.append(todo)
    }
    
    func updateSelectedTodo(title: String, description: String) {
        if let index = todos.firstIndex(where: { $0.id == selectedTodo?.id }) {
            todos[index].update(title: title, description: description)
        }
    }
    
    func delete(_ todo: ToDo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos.remove(at: index)
        }
    }
    
    func markComplete() {
        if let index = todos.firstIndex(where: { $0.id == selectedTodo?.id }) {
            todos[index].completed = true
        }
    }
    

    
}
