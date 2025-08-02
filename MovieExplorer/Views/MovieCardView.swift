//
//  MovieCardView.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 140, height: 210)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
                .shadow(radius: 8)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 140, height: 210)
                    .overlay(Text("No Image").foregroundColor(.white))
                    .shadow(radius: 8)
            }
            
            Text(movie.title)
                .font(.subheadline)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption)
                Text(String(format: "%.1f", movie.vote_average))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 140)
    }
}

//#Preview {
//    MovieCardView()
//}
