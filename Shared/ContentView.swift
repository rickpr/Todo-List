//
//  ContentView.swift
//  Shared
//
//  Created by fdisk on 8/1/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    enum TodoListStatus {
        case complete
        case in_progress
    }
    @State private var selectedStatus: TodoListStatus = .in_progress
    private func todo_list_predicate(status: TodoListStatus) -> String {
        switch status {
        case .in_progress:
            return "completed_at == nil"
        case .complete:
            return "completed_at != nil"
        }
    }

    var body: some View {
        VStack {
            Picker("Status", selection: $selectedStatus) {
                Text("In Progress").tag(TodoListStatus.in_progress)
                Text("Complete").tag(TodoListStatus.complete)
            }
            .pickerStyle(.segmented)
            Todo_List_View(predicate: todo_list_predicate(status: selectedStatus))
            Create_Todo_Item()
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
