//
//  Edit Todo Item.swift
//  Todo List
//
//  Created by fdisk on 8/24/22.
//

import SwiftUI

struct Edit_Todo_Item: View {
    @State private var todo_item: Todo_Item
    @State private var todo_item_title: String
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    init(todo_item: Todo_Item) {
        _todo_item = State(initialValue: todo_item)
        _todo_item_title = State(initialValue: todo_item.title ?? "")
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
                    save_item()
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
    
    private func save_item() {
        withAnimation {
            todo_item.title = todo_item_title
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

struct Edit_Todo_Item_Previews: PreviewProvider {
    static var previews: some View {
        Edit_Todo_Item(todo_item: Todo_Item())
    }
}
