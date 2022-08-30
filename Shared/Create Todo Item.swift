//
//  Create Todo Item.swift
//  Todo List
//
//  Created by fdisk on 8/14/22.
//

import SwiftUI


struct Create_Todo_Item: View {
    @State private var todo_item_title: String = ""
    @State private var parent_todo_item: Todo_Item?
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    init(parent_todo_item: Todo_Item?) {
        _parent_todo_item = State(initialValue: parent_todo_item)
    }
    var body: some View {
        VStack {
            HStack {
                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text("Cancel").padding()
                }
                Spacer()
                Button {
                    addItem()
                    dismiss()
                } label: {
                    Text("Save").padding()
                }
                .disabled(todo_item_title == "")
            }
            Spacer()
            TextField(
                "What needs to be done?",
                text: $todo_item_title
            )
            .padding()
        }
    }
    
    private func addItem() {
        withAnimation {
            let newTodoItem = Todo_Item(context: viewContext)
            newTodoItem.title = todo_item_title
            newTodoItem.parent_todo_item = parent_todo_item
            
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

struct Create_Todo_Item_Previews: PreviewProvider {
    static var previews: some View {
        Create_Todo_Item(parent_todo_item: nil)
    }
}
