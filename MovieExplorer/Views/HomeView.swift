//
//  HomeView.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var service = TMDBService()
    
    var body: some View {
        NavigationStack {
            Group {
                if service.nowPlayingMovies.isEmpty {
                    ProgressView("Loading...")
                } else {
                    ScrollView {
                        VStack(spacing: 24) {
                            MovieSectionView(title: "Now Playing", movies: service.nowPlayingMovies)
                            MovieSectionView(title: "Popular", movies: service.popularMovies)
                            MovieSectionView(title: "Top Rated", movies: service.topRatedMovies)
                            MovieSectionView(title: "Upcoming", movies: service.upcomingMovies)
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Movie Explorer")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await service.fetchHomeData()
        }
    }
}
//#Preview {
//    HomeView()
//}
