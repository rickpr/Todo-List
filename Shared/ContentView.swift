//
//  ContentView.swift
//  Shared
//
//  Created by fdisk on 8/1/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedStatus: TodoListStatus = .in_progress
    var body: some View {
        Splash_Page()
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
