//
//  MovieListItemView.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import SwiftUI

struct MovieListItemView: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 16) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 120)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 120)
                    .overlay(Text("No Image").font(.caption).foregroundColor(.white))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text(String(format: "%.1f", movie.vote_average))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
//#Preview {
//    MovieListItemView()
//}
