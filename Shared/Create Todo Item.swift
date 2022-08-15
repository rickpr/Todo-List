//
//  Create Todo Item.swift
//  Todo List
//
//  Created by fdisk on 8/14/22.
//

import SwiftUI

struct Create_Todo_Item: View {
    @State private var todo_item_text: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        HStack {
            TextField(
                "What needs to be done?",
                text: $todo_item_text
            )
            Button { addItem() } label: {
                Image(systemName: "plus")
            }
            .disabled(todo_item_text == "")
        }
        .padding()
    }
    
    private func addItem() {
        withAnimation {
            let newTodoItem = Todo_Item(context: viewContext)
            newTodoItem.text = todo_item_text
            newTodoItem.created_at = Date()
            newTodoItem.updated_at = Date()
            
            do {
                try viewContext.save()
                todo_item_text = ""
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

struct Create_Todo_Item_Previews: PreviewProvider {
    static var previews: some View {
        Create_Todo_Item()
    }
}
