//
//  MovieDetailView.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @StateObject private var service = TMDBService()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var myListManager: MyListManager
    
    var isMovieInList: Bool {
        myListManager.myList.contains(movie)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                if let url = movie.backdropURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea(.all, edges: .top)
                            //.frame(width: .infinity, height: 300)
                        

                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 300)
                    }
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 300)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                    
                    if let tagline = service.movieDetails?.tagline, !tagline.isEmpty {
                        Text(tagline)
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", service.movieDetails?.vote_average ?? movie.vote_average))
                        Text("(\(service.movieDetails?.vote_count ?? 0) votes)")
                            .foregroundColor(.secondary)
                    }
                    
                    Button {
                        if isMovieInList {
                            myListManager.removeFromMyList(movie)
                        } else {
                            myListManager.addToMyList(movie)
                        }
                    } label: {
                        Text(isMovieInList ? "Remove from My List" : "Add to My List")
                            .font(.headline)
                            .foregroundColor(isMovieInList ? .white : .black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isMovieInList ? Color.red : Color.yellow)
                            .cornerRadius(12)
                    }
                    
                    if let overview = movie.overview {
                        Text("Overview")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(overview)
                            .foregroundColor(.secondary)
                    }
                    
                    if let director = service.castAndCrew?.crew.first(where: { $0.job == "Director" }) {
                        Text("Director")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(director.name)
                            .foregroundColor(.secondary)
                    }
                    
                    if let cast = service.castAndCrew?.cast, !cast.isEmpty {
                        Text("Cast")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(cast) { member in
                                    VStack {
                                        if let url = member.profileURL {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 80, height: 80)
                                                    .clipShape(Circle())
                                            } placeholder: {
                                                Image(systemName: "person.circle.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundColor(.gray)
                                            }
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                        } else {
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                                .foregroundColor(.gray)
                                                .clipShape(Circle())
                                        }
                                        Text(member.name)
                                            .font(.caption)
                                            .lineLimit(1)
                                        Text(member.character ?? "")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                }
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    if !service.similarMovies.isEmpty {
                        Text("Similar Movies")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(service.similarMovies) { similarMovie in
                                    NavigationLink(destination: MovieDetailView(movie: similarMovie)) {
                                        MovieCardView(movie: similarMovie)
                                            .frame(width: 140)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .task {
            await service.fetchMovieDetails(for: movie.id)
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MovieDetailView(movie: Movie.sampleMovie).environmentObject(MyListManager())
}
