//
//  NetworkManager.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case networkError(Error)
    case apiError(String) // For handling specific TMDb API errors
}

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
    
    // A nested struct to hold the pre-parsed fallback data.
    private struct FallbackContent: Codable {
        let nowPlaying: MovieListResponse
        let popular: MovieListResponse
        let topRated: MovieListResponse
        let upcoming: MovieListResponse
        let movieDetails: MovieDetails
        let castAndCrew: CreditsResponse
        let similar: MovieListResponse
    }
    
    // A generic function to fetch and decode data from a URL.
    // It now accepts a pre-parsed fallback object instead of raw Data.
    func fetchData<T: Codable>(from urlString: String, fallback: T) async -> T? {
        print("Attempting to fetch data from: \(urlString)")
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return fallback
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("API call failed: Response is not a valid HTTP response.")
                return fallback
            }
            
            // Check for a non-200 status code and print the error message if available
            if httpResponse.statusCode != 200 {
                print("API call failed with status code: \(httpResponse.statusCode)")
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response body: \(responseString)")
                }
                return fallback
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            print("Successfully fetched and decoded data from: \(urlString)")
            return decodedData
        } catch {
            print("An unexpected error occurred during API fetch.")
            print("Error: \(error.localizedDescription)")
            print("Using fallback data for: \(urlString)")
            return fallback
        }
    }
    
    func testAPIConnection() async {
        let testUrlString = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        guard let url = URL(string: testUrlString) else {
            print("Invalid URL for API test.")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("API test failed: Response is not a valid HTTP response.")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("API test successful! Status Code: \(httpResponse.statusCode). Raw data received:")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                } else {
                    print("Could not convert data to string.")
                }
            } else {
                print("API test failed. Status Code: \(httpResponse.statusCode).")
            }
        } catch {
            print("API test failed with error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchHomeData() async {
        // Parse fallback data once
        guard let fallbackJsonData = fallbackData.data(using: .utf8),
              let fallbackContent = try? JSONDecoder().decode(FallbackContent.self, from: fallbackJsonData) else {
            print("Failed to parse fallback data.")
            return
        }
        
        // Fetch Now Playing
        let nowPlayingURL = "\(baseURL)/movie/now_playing?api_key=\(apiKey)"
        let nowPlayingResponse = await fetchData(from: nowPlayingURL, fallback: fallbackContent.nowPlaying)
        self.nowPlayingMovies = nowPlayingResponse?.results ?? []
        
        // Fetch Popular
        let popularURL = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        let popularResponse = await fetchData(from: popularURL, fallback: fallbackContent.popular)
        self.popularMovies = popularResponse?.results ?? []
        
        // Fetch Top Rated
        let topRatedURL = "\(baseURL)/movie/top_rated?api_key=\(apiKey)"
        let topRatedResponse = await fetchData(from: topRatedURL, fallback: fallbackContent.topRated)
        self.topRatedMovies = topRatedResponse?.results ?? []
        
        // Fetch Upcoming
        let upcomingURL = "\(baseURL)/movie/upcoming?api_key=\(apiKey)"
        let upcomingResponse = await fetchData(from: upcomingURL, fallback: fallbackContent.upcoming)
        self.upcomingMovies = upcomingResponse?.results ?? []
    }
    
    @MainActor
    func fetchMovieDetails(for id: Int) async {
        // Parse fallback data once
        guard let fallbackJsonData = fallbackData.data(using: .utf8),
              let fallbackContent = try? JSONDecoder().decode(FallbackContent.self, from: fallbackJsonData) else {
            print("Failed to parse fallback data.")
            return
        }
        
        let detailsURL = "\(baseURL)/movie/\(id)?api_key=\(apiKey)"
        self.movieDetails = await fetchData(from: detailsURL, fallback: fallbackContent.movieDetails)
        
        let creditsURL = "\(baseURL)/movie/\(id)/credits?api_key=\(apiKey)"
        self.castAndCrew = await fetchData(from: creditsURL, fallback: fallbackContent.castAndCrew)
        
        let similarURL = "\(baseURL)/movie/\(id)/similar?api_key=\(apiKey)"
        let similarResponse = await fetchData(from: similarURL, fallback: fallbackContent.similar)
        self.similarMovies = similarResponse?.results ?? []
    }
}

