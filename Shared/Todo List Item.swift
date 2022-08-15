//
//  Todo List Item.swift
//  Todo List
//
//  Created by fdisk on 8/13/22.
//

import SwiftUI

struct Todo_List_Item: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var status: TodoListStatus
    @State private var todo_item: Todo_Item

    init(status: TodoListStatus, todo_item: Todo_Item) {
        self.status = status
        self.todo_item = todo_item
    }
    
    var body: some View {
        NavigationLink(
            destination: Todo_List_View(status: status, parent_todo_item: todo_item)
        ) { Text(todo_item.text ?? "") }
        .swipeActions() {
            Button {
                todo_item.completed_at = Date()
                saveItem()
            } label: {
                Image(systemName: "checkmark.circle")
            }
            .tint(.green)
            Button(role: .destructive) {
                viewContext.delete(todo_item)
                saveItem()
            } label: {
                Image(systemName: "trash")
            }
        }
    }
    private func saveItem() {
        withAnimation {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError(
                    "Unresolved error \(nsError), \(nsError.userInfo)"
                )
            }
        }
    }
}

struct Todo_List_Item_Previews: PreviewProvider {
    static var previews: some View {
        Todo_List_Item(status: TodoListStatus.in_progress, todo_item: Todo_Item())
    }
}
