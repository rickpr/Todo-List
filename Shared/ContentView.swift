//
//  ContentView.swift
//  Shared
//
//  Created by fdisk on 8/1/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var new_todo_item: String = ""
    @State private var showing_completed: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \Todo_Item.created_at, ascending: true
            )
        ],
        predicate: NSPredicate(format: "completed_at == nil"),
        animation: .default)
    private var todo_items: FetchedResults<Todo_Item>
    
    var body: some View {
        VStack {
            HStack {
                TextField("What needs to be done?", text: $new_todo_item)
                Button("Add") { addItem() }
                    .disabled(new_todo_item == "")
            }
            .padding()
            List {
                ForEach(todo_items) { todo_item in
                    Toggle(
                        todo_item.text ?? "",
                        isOn: Binding<Bool>(
                            get: { todo_item.completed_at != nil },
                            set: {
                                if $0 {
                                    todo_item.completed_at = Date()
                                } else {
                                    todo_item.completed_at = nil
                                }
                                
                            }
                        )
                    )
                }
                .onDelete(perform: deleteTodoItems)
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newTodoItem = Todo_Item(context: viewContext)
            newTodoItem.text = new_todo_item
            newTodoItem.created_at = Date()
            newTodoItem.updated_at = Date()
            
            do {
                try viewContext.save()
                new_todo_item = ""
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )
    }
}
