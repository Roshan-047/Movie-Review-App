//
//  MovieExplorerApp.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import SwiftUI

@main
struct MovieExplorerApp: App {
    @StateObject private var myListManager = MyListManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                MyListView()
                    .tabItem {
                        Label("My List", systemImage: "bookmark.fill")
                    }
            }
            .environmentObject(myListManager)
            .preferredColorScheme(.dark) // A nice dark theme for the app
        }
    }
}
