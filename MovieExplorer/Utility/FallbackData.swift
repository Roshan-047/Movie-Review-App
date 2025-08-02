////
////  FallbackData.swift
////  MovieExplorer
////
////  Created by Roshan Karn on 02/08/25.
////
//
//import Foundation
//
//struct FallbackData {
//    
//    static let nowPlaying: [Movie] = {
//        let jsonString = """
//        {
//        "dates": {
//        "maximum": "2025-04-16",
//        "minimum": "2025-03-05"
//        },
//        "page": 1,
//        "results": [
//        {
//        "adult": false,
//        "backdrop_path": "/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg",
//        "genre_ids": [
//        10751,
//        35,
//        12,
//        14
//        ],
//        "id": 950387,
//        "original_language": "en",
//        "original_title": "A Minecraft Movie",
//        "overview": "Four misfits find themselves struggling with ordinary problems when
//        they are suddenly pulled through a mysterious portal into the Overworld: a bizarre,
//        cubic wonderland that thrives on imagination. To get back home, they'll have to master
//        this world while embarking on a magical quest with an unexpected, expert crafter,
//        Steve.",
//        "popularity": 824.7134,
//        "poster_path": "/iPPTGh2OXuIv6d7cwuoPkw8govp.jpg",
//        "release_date": "2025-03-31",
//        "title": "A Minecraft Movie",
//        "video": false,
//        "vote_average": 6.1,
//        "vote_count": 482
//        },
//        {
//        "adult": false,
//        "backdrop_path": "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg",
//        "genre_ids": [
//        14,
//        12,
//        28
//        ],
//        "id": 324544,
//        "original_language": "en",
//        "original_title": "In the Lost Lands",
//        "overview": "A queen sends the powerful and feared sorceress Gray Alys to the
//        
//        ghostly wilderness of the Lost Lands in search of a magical power, where the sorceress
//        and her guide, the drifter Boyce must outwit and outfight man and demon.",
//        "popularity": 873.5678,
//        "poster_path": "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg",
//        "release_date": "2025-02-27",
//        "title": "In the Lost Lands",
//        "video": false,
//        "vote_average": 5.926,
//        "vote_count": 101
//        },
//        ]
//        }
//        """
//        
//        return decodeFallbackMovies(jsonString: jsonString, category: "Popular")
//    }()
//    
//    static let popularMovies: [Movie] = {
//        let jsonString = """
//        {
//          "page": 1,
//          "results": [
//            {
//              "adult": false,
//              "backdrop_path": "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg",
//              "genre_ids": [14, 12, 28],
//              "id": 324544,
//              "original_language": "en",
//              "original_title": "In the Lost Lands",
//              "overview": "A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands in search of a magical power, where the sorceress and her guide, the drifter Boyce must outwit and outfight man and demon.",
//              "popularity": 789.8905,
//              "poster_path": "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg",
//              "release_date": "2025-02-27",
//              "title": "In the Lost Lands",
//              "video": false,
//              "vote_average": 6.388,
//              "vote_count": 156
//            },
//            {
//              "adult": false,
//              "backdrop_path": "/k32XKMjmXMGeydykD32jfER3BVI.jpg",
//              "genre_ids": [28, 9648, 18],
//              "id": 1045938,
//              "original_language": "en",
//              "original_title": "G20",
//              "overview": "After the G20 Summit is overtaken by terrorists, President Danielle Sutton must bring all her statecraft and military experience to defend her family and her fellow leaders.",
//              "popularity": 687.7088,
//              "poster_path": "/tSee9gbGLfqwvjoWoCQgRZ4Sfky.jpg",
//              "release_date": "2025-04-09",
//              "title": "G20",
//              "video": false,
//              "vote_average": 6.449,
//              "vote_count": 186
//            }
//          ],
//          "total_pages": 49754,
//          "total_results": 995075
//        }
//        """
//        return decodeFallbackMovies(jsonString: jsonString, category: "Popular")
//    }()
//    
//    static let topRatedMovies: [Movie] = {
//        let jsonString = """
//        {
//          "page": 1,
//          "results": [
//            {
//              "adult": false,
//              "backdrop_path": "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg",
//              "genre_ids": [18, 80],
//              "id": 278,
//              "original_language": "en",
//              "original_title": "The Shawshank Redemption",
//              "overview": "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
//              "popularity": 45.3817,
//              "poster_path": "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
//              "release_date": "1994-09-23",
//              "title": "The Shawshank Redemption",
//              "video": false,
//              "vote_average": 8.7,
//              "vote_count": 28127
//            },
//            {
//              "adult": false,
//              "backdrop_path": "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
//              "genre_ids": [18, 80],
//              "id": 238,
//              "original_language": "en",
//              "original_title": "The Godfather",
//              "overview": "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
//              "popularity": 41.4734,
//              "poster_path": "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
//              "release_date": "1972-03-14",
//              "title": "The Godfather",
//              "video": false,
//              "vote_average": 8.7,
//              "vote_count": 21329
//            }
//          ]
//        }
//        """
//        return decodeFallbackMovies(jsonString: jsonString, category: "Top Rated")
//    }()
//    
//    static let upcomingMovies: [Movie] = {
//        let jsonString = """
//        {
//          "dates": {
//            "maximum": "2025-05-07",
//            "minimum": "2025-04-16"
//          },
//          "page": 1,
//          "results": [
//            {
//              "adult": false,
//              "backdrop_path": "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg",
//              "genre_ids": [14, 12, 28],
//              "id": 324544,
//              "original_language": "en",
//              "original_title": "In the Lost Lands",
//              "overview": "A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands in search of a magical power, where the sorceress and her guide, the drifter Boyce must outwit and outfight man and demon.",
//              "popularity": 837.1695,
//              "poster_path": "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg",
//              "release_date": "2025-02-27",
//              "title": "In the Lost Lands",
//              "video": false,
//              "vote_average": 6.364,
//              "vote_count": 147
//            },
//            {
//              "adult": false,
//              "backdrop_path": "/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg",
//              "genre_ids": [10751, 35, 12, 14],
//              "id": 950387,
//              "original_language": "en",
//              "original_title": "A Minecraft Movie",
//              "overview": "Four misfits find themselves struggling with ordinary problems when they are suddenly pulled through a mysterious portal into the Overworld: a bizarre, cubic wonderland that thrives on imagination. To get back home, they'll have to master this world while embarking on a magical quest with an unexpected, expert crafter, Steve.",
//              "popularity": 695.7057,
//              "poster_path": "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg",
//              "release_date": "2025-03-31",
//              "title": "A Minecraft Movie",
//              "video": false,
//              "vote_average": 6.077,
//              "vote_count": 523
//            }
//          ],
//          "total_pages": 68,
//          "total_results": 1357
//        }
//        """
//        return decodeFallbackMovies(jsonString: jsonString, category: "Upcoming")
//    }()
//    
//    static let similar: [Movie] = {
//        let jsonString = """
//{
//"page": 1,
//"results": [
//{
//"adult": false,
//"backdrop_path": null,
//"genre_ids": [
//35,
//10749
//],
//"id": 25084,
//"original_language": "en",
//"original_title": "50 Ways to Leave Your Lover",
//"overview": "s after an earthquake convince Owen, a writer of hack \"as told to\"
//autobiographies, to leave L.A. He burns his bridges telling people what he really
//thinks, quits his current client (a randy astronaut), and heads for the airport.
//Waiting for his flight to New York, he sees Val, a friend of his latest ex; they chat,
//and Owen postpones leaving just to make sure she's not for him.",
//"popularity": 0.3373,
//"poster_path": "/7MO9NqdQ9m5NN3E2cV1peU1CX3O.jpg",
//"release_date": "2004-09-10",
//"title": "50 Ways to Leave Your Lover",
//"video": false,
//"vote_average": 4.2,
//"vote_count": 14
//},
//{
//"adult": false,
//"backdrop_path": null,
//"genre_ids": [
//14
//],
//"id": 615372,
//"original_language": "en",
//"original_title": "Re/cycle",
//"overview": "With input from actor and writer Jan Hlobil, director and
//cinematographer Rene Smaal presents a film in the true surrealist tradition, in the
//sense that only 'found' elements were used, and that it defies interpretation based on
//ordinary cause-and-effect time sequence.",
//"popularity": 0.5832,
//"poster_path": "/9ui7D4mC1K0hSFK4Sjc2hUfVjMf.jpg",
//"release_date": "2019-06-07",
//"title": "Re/cycle",
//"video": false,
//"vote_average": 7.7,
//"vote_count": 42
//},
//{
//
//"adult": false,
//"backdrop_path": "/qsxhnirlp7y4Ae9bd11oYJSX59j.jpg",
//"genre_ids": [
//10751,
//16,
//35,
//14,
//12,
//10402
//],
//"id": 446893,
//"original_language": "en",
//"original_title": "Trolls World Tour",
//"overview": "Queen Poppy and Branch make a surprising discovery -- there are
//other Troll worlds beyond their own, and their distinct differences create big clashes
//between these various tribes. When a mysterious threat puts all of the Trolls across
//the land in danger, Poppy, Branch, and their band of friends must embark on an epic
//quest to create harmony among the feuding Trolls to unite them against certain doom.",
//"popularity": 8.1483,
//"poster_path": "/7W0G3YECgDAfnuiHG91r8WqgIOe.jpg",
//"release_date": "2020-03-11",
//"title": "Trolls World Tour",
//"video": false,
//"vote_average": 7.285,
//"vote_count": 2165
//},
//],
//"total_pages": 10459,
//"total_results": 209176
//}
//"""
//        return  decodeFallbackMovies(jsonString: jsonString, category: "similar")
//    }()
//    
//    private static func decodeFallbackMovies(jsonString: String, category: String) -> [Movie] {
//        guard let data = jsonString.data(using: .utf8) else {
//            print("Error: Could not convert \(category) fallback JSON string to Data.")
//            return []
//        }
//        do {
//            let decoder = JSONDecoder()
//            // If the JSON for a movie detail has different fields, you might need a separate MovieDetail struct
//            // For now, assuming the MovieResponse structure covers it.
//            let response = try decoder.decode(MovieResponse.self, from: data)
//            return response.results
//        } catch {
//            print("Error decoding \(category) fallback movies: \(error.localizedDescription)")
//            return []
//        }
//    }
//}
