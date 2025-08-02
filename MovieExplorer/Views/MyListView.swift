//
//  MyListView.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import SwiftUI

struct MyListView: View {
    @EnvironmentObject private var myListManager: MyListManager
    
    var body: some View {
        NavigationStack {
            Group {
                if myListManager.myList.isEmpty {
                    Text("Your list is empty. Add movies from the Home tab.")
                        .foregroundColor(.secondary)
                        .padding()
                        .multilineTextAlignment(.center)
                } else {
                    List {
                        ForEach(myListManager.myList) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieListItemView(movie: movie)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My List")
        }
    }
}

#Preview {
    MyListView()
}
