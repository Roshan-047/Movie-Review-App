//
//  NetworkManager.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import Foundation


class TMDBService: ObservableObject {
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var movieDetails: MovieDetails?
    @Published var castAndCrew: CreditsResponse?
    @Published var similarMovies: [Movie] = []
    
    private let apiKey = "9c74797327fd8d722413616a2d2be814"
    private let baseURL = "https://api.themoviedb.org/3"
    
    // MARK: - Generic JSON Loader
    private func loadFallback<T: Decodable>(from fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Could not find \(fileName).json in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Failed to decode \(fileName).json: \(error)")
            return nil
        }
    }
    
    func fetchData<T: Codable>(from urlString: String, fallback: T) async -> T? {
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return fallback
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return fallback
            }
            
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            print("Error fetching data from \(urlString): \(error.localizedDescription)")
            return fallback
        }
    }
    
    // MARK: - Fetch Home Data
    @MainActor
    func fetchHomeData() async {
        let fallbackNowPlaying: MovieListResponse = loadFallback(from: "nowPlaying") ?? MovieListResponse(results: [])
        let fallbackPopular: MovieListResponse = loadFallback(from: "popular") ?? MovieListResponse(results: [])
        let fallbackTopRated: MovieListResponse = loadFallback(from: "topRated") ?? MovieListResponse(results: [])
        let fallbackUpcoming: MovieListResponse = loadFallback(from: "upcoming") ?? MovieListResponse(results: [])
        
        let nowPlayingURL = "\(baseURL)/movie/now_playing?api_key=\(apiKey)"
        let popularURL = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        let topRatedURL = "\(baseURL)/movie/top_rated?api_key=\(apiKey)"
        let upcomingURL = "\(baseURL)/movie/upcoming?api_key=\(apiKey)"
        
        self.nowPlayingMovies = (await fetchData(from: nowPlayingURL, fallback: fallbackNowPlaying))?.results ?? []
        self.popularMovies = (await fetchData(from: popularURL, fallback: fallbackPopular))?.results ?? []
        self.topRatedMovies = (await fetchData(from: topRatedURL, fallback: fallbackTopRated))?.results ?? []
        self.upcomingMovies = (await fetchData(from: upcomingURL, fallback: fallbackUpcoming))?.results ?? []
    }
    
    // MARK: - Fetch Movie Details
    @MainActor
    func fetchMovieDetails(for id: Int) async {
        let fallbackDetails: MovieDetails = loadFallback(from: "movie_details") ?? MovieDetails(id: 01, title: "", tagline: "", overview: "", poster_path: "", backdrop_path: "", release_date: "", runtime: 12, vote_average: 9.2, vote_count: 324)
        let fallbackCredits: CreditsResponse = loadFallback(from: "cast_and_crew") ?? CreditsResponse( cast: [], crew: [])
        let fallbackSimilar: MovieListResponse = loadFallback(from: "similar") ?? MovieListResponse(results: [])
        
        let detailsURL = "\(baseURL)/movie/\(id)?api_key=\(apiKey)"
        let creditsURL = "\(baseURL)/movie/\(id)/credits?api_key=\(apiKey)"
        let similarURL = "\(baseURL)/movie/\(id)/similar?api_key=\(apiKey)"
        
        self.movieDetails = await fetchData(from: detailsURL, fallback: fallbackDetails)
        self.castAndCrew = await fetchData(from: creditsURL, fallback: fallbackCredits)
        self.similarMovies = (await fetchData(from: similarURL, fallback: fallbackSimilar))?.results ?? []
    }
}


