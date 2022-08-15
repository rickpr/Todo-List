//
//  Todo List View.swift
//  Todo List
//
//  Created by fdisk on 8/14/22.
//

import SwiftUI

struct Todo_List_View: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var todo_items: FetchedResults<Todo_Item>
    init(predicate: String) {
        _todo_items = FetchRequest<Todo_Item> (
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \Todo_Item.created_at, ascending: true
                )
            ],
            predicate: NSPredicate(format: predicate),
            animation: .default)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todo_items) { todo_item in
                    Todo_List_Item(todo_item: todo_item)
                }
                .onDelete(perform: deleteTodoItems)
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
        Todo_List_View(predicate: "completed_at == nil")
    }
}
