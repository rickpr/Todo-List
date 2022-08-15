//
//  ContentView.swift
//  Shared
//
//  Created by fdisk on 8/1/22.
//

import SwiftUI
import CoreData

enum TodoListStatus {
    case complete
    case in_progress
}

struct ContentView: View {
    @State private var selectedStatus: TodoListStatus = .in_progress
    var body: some View {
        VStack {
            Picker("Status", selection: $selectedStatus) {
                Text("In Progress").tag(TodoListStatus.in_progress)
                Text("Complete").tag(TodoListStatus.complete)
            }
            .pickerStyle(.segmented)
            Todo_List_View(status: selectedStatus, parent_todo_item: nil)
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
