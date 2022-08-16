//
//  Splash Page.swift
//  Todo List
//
//  Created by fdisk on 8/16/22.
//

import SwiftUI

struct Splash_Page: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("Splash Image")
                Text("DOCKET").font(.headline).foregroundColor(.blue).padding()
                NavigationLink(destination: Main_Page()) {
                    HStack {
                        Text("Get Started")
                        Image(systemName: "arrow.right")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16))
                    .padding()
                }
            }
        }
    }
}

struct Splash_Page_Previews: PreviewProvider {
    static var previews: some View {
        Splash_Page()
    }
}
