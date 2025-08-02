//
//  Movie.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import Foundation

struct Movie: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
    
    // A computed property to get the full poster URL
    var posterURL: URL? {
        guard let path = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    // A computed property to get the full backdrop URL
    var backdropURL: URL? {
        guard let path = backdrop_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w1280\(path)")
    }
    
    static let sampleMovie: Movie = Movie(id: 950387, title: "A Minecraft Movie", overview: "abc", poster_path: "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg", backdrop_path: "/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg", vote_average: 6.4)
}

struct MovieListResponse: Codable {
    let results: [Movie]
}

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let tagline: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let release_date: String?
    let runtime: Int?
    let vote_average: Double
    let vote_count: Int
}

struct CastMember: Identifiable, Codable {
    let id: Int
    let name: String
    let character: String?
    let profile_path: String?
    
    var profileURL: URL? {
        guard let path = profile_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(path)")
    }
}

struct CrewMember: Identifiable, Codable {
    let id: Int
    let name: String
    let job: String?
}

struct CreditsResponse: Codable {
    let cast: [CastMember]
    let crew: [CrewMember]
}


let fallbackData = """
{
    "nowPlaying": {
        "page": 1,
        "results": [
            { "id": 950387, "title": "A Minecraft Movie", "overview": "...", "poster_path": "/iPPTGh20XuIv6d7cwuoPkw8govp.jpg", "backdrop_path": "/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg", "vote_average": 6.1 },
            { "id": 324544, "title": "In the Lost Lands", "overview": "...", "poster_path": "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg", "backdrop_path": "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg", "vote_average": 5.9 }
        ]
    },
    "popular": {
        "page": 1,
        "results": [
            { "id": 324544, "title": "In the Lost Lands", "overview": "...", "poster_path": "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg", "backdrop_path": "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg", "vote_average": 6.3 },
            { "id": 1045938, "title": "G20", "overview": "...", "poster_path": "/tSee9gbGLfqwvjoWoCQgRZ4Sfky.jpg", "backdrop_path": "/k32XKMjmXMGeydydykD32jfER3BVI.jpg", "vote_average": 6.4 }
        ]
    },
    "topRated": {
        "page": 1,
        "results": [
            { "id": 278, "title": "The Shawshank Redemption", "overview": "...", "poster_path": "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", "backdrop_path": "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg", "vote_average": 8.7 },
            { "id": 238, "title": "The Godfather", "overview": "...", "poster_path": "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg", "backdrop_path": "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg", "vote_average": 8.7 }
        ]
    },
    "upcoming": {
        "dates": { "maximum": "2025-05-07", "minimum": "2025-04-16" },
        "page": 1,
        "results": [
            { "id": 324544, "title": "In the Lost Lands", "overview": "...", "poster_path": "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg", "backdrop_path": "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg", "vote_average": 6.3 },
            { "id": 950387, "title": "A Minecraft Movie", "overview": "...", "poster_path": "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", "backdrop_path": "/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg", "vote_average": 6.0 }
        ]
    },
    "movieDetails": {
        "id": 950387, "title": "A Minecraft Movie", "tagline": "Be there and be square.", "overview": "Four misfits find themselves struggling with ordinary problems when they are suddenly pulled through a mysterious portal into the Overworld: a bizarre, cubic wonderland that thrives on imagination. To get back home, they'll have to master this world while embarking on a magical quest with an unexpected, expert crafter, Steve.", "poster_path": "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", "backdrop_path": "/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg", "release_date": "2025-03-31", "runtime": 101, "vote_average": 6.08, "vote_count": 528
    },
    "castAndCrew": {
        "id": 950387,
        "cast": [
            { "id": 117642, "name": "Jason Momoa", "character": "Garrett", "profile_path": "/6dEFBpZH8C8OijsynkSajQT99Pb.jpg" },
            { "id": 70851, "name": "Jack Black", "character": "Steve", "profile_path": "/9QKdFKfc3Zi5XwnQHrFukFMpo5o.jpg" },
            { "id": 2680307, "name": "Sebastian Eugene Hansen", "character": "Henry", "profile_path": "/40HNkoB3RKPMPgLhTyKQU6kG0sc.jpg" },
            { "id": 2604515, "name": "Emma Myers", "character": "Natalie", "profile_path": "/xBJsFGAL3sOIxMUA0sMVEKKpAL4.jpg" },
            { "id": 1075037, "name": "Danielle Brooks", "character": "Dawn", "profile_path": "/dEonf59ukDW8LaN7vwj8WMmXrXf.jpg" }
        ],
        "crew": [
            { "id": 1121, "name": "Jared Hess", "job": "Director" }
        ]
    },
    "similar": {
        "page": 1,
        "results": [
            { "id": 25084, "title": "50 Ways to Leave Your Lover", "overview": "...", "poster_path": "/7MO9NqdQ9m5NN3E2cV1peU1CX3O.jpg", "backdrop_path": null, "vote_average": 4.2 },
            { "id": 446893, "title": "Trolls World Tour", "overview": "...", "poster_path": "/7W0G3YECgDAfnuiHG91r8WqgIOe.jpg", "backdrop_path": "/qsxhnirlp7y4Ae9bd11oYJSX59j.jpg", "vote_average": 7.2 }
        ]
    }
}
"""
