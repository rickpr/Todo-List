//
//  Todo List View.swift
//  Todo List
//
//  Created by fdisk on 8/14/22.
//

import SwiftUI

struct Todo_List_View: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var status: TodoListStatus
    @State private var parent_todo_item: Todo_Item?
    @FetchRequest var todo_items: FetchedResults<Todo_Item>
    
    init(status: TodoListStatus, parent_todo_item: Todo_Item?) {
        _status = State(initialValue: status)
        _parent_todo_item = State(initialValue: parent_todo_item)
        var completed_predicate = ""
        switch status {
        case .in_progress:
            completed_predicate = "completed_at == nil"
        case .complete:
            completed_predicate = "completed_at != nil"
        }
        let predicate = (parent_todo_item != nil) ?
        NSPredicate(format: "\(completed_predicate) && parent_todo_item == %@", parent_todo_item!) :
        NSPredicate(format: "\(completed_predicate) && parent_todo_item == nil")
        _todo_items = FetchRequest<Todo_Item> (
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \Todo_Item.created_at, ascending: true
                )
            ],
            predicate: predicate,
            animation: .default)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todo_items) { todo_item in
                        Todo_List_Item(status: status, todo_item: todo_item)
                    }
                    .onDelete(perform: deleteTodoItems)
                }
                Create_Todo_Item(parent_todo_item: parent_todo_item)
            }
        }
    }
    
    private func deleteTodoItems(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                todo_items[$0]
            }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

struct Todo_List_View_Previews: PreviewProvider {
    static var previews: some View {
        Todo_List_View(status: TodoListStatus.in_progress, parent_todo_item: nil)
    }
}