//
//  MovieSectionView.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import SwiftUI

struct MovieSectionView: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieCardView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
//#Preview {
//    MovieSectionView()
//}
