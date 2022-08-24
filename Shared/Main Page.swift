//
//  Main Page.swift
//  Todo List
//
//  Created by fdisk on 8/16/22.
//

import SwiftUI

enum TodoListStatus {
    case complete
    case in_progress
}

struct Main_Page: View {
    @State private var selectedStatus: TodoListStatus = .in_progress
    var body: some View {
        VStack {
            Picker("Status", selection: $selectedStatus) {
                Text("In Progress").tag(TodoListStatus.in_progress)
                Text("Complete").tag(TodoListStatus.complete)
            }
            .pickerStyle(.segmented)
            NavigationView {
                Todo_List_View(status: selectedStatus, parent_todo_item: nil)
            }
        }
        .navigationBarHidden(true)
    }
}

struct Main_Page_Previews: PreviewProvider {
    static var previews: some View {
        Main_Page()
    }
}
