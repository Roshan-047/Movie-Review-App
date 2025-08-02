//
//  MovieExplorerViewModel.swift
//  MovieExplorer
//
//  Created by Roshan Karn on 02/08/25.
//

import Foundation

class MyListManager: ObservableObject {
    @Published var myList: [Movie] = []
    private let listKey = "myList"
    
    init() {
        loadMyList()
    }
    
    func loadMyList() {
        if let savedData = UserDefaults.standard.data(forKey: listKey) {
            if let decodedList = try? JSONDecoder().decode([Movie].self, from: savedData) {
                myList = decodedList
                return
            }
        }
        myList = []
    }
    
    func saveMyList() {
        if let encodedData = try? JSONEncoder().encode(myList) {
            UserDefaults.standard.set(encodedData, forKey: listKey)
        }
    }
    
    func addToMyList(_ movie: Movie) {
        if !myList.contains(movie) {
            myList.append(movie)
            saveMyList()
        }
    }
    
    func removeFromMyList(_ movie: Movie) {
        myList.removeAll { $0.id == movie.id }
        saveMyList()
    }
}
