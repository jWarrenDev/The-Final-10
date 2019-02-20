//
//  MovieController.swift
//  The 10 - Jerrick Warren
//
//  Created by Jerrick Warren on 2/13/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

import Foundation

class MovieController {
    
    //MARK: - Properties
    
    var nowPlayingMovies : [Results] = []
    var upcomingMovies   : [Results] = []
    
    
    // MARK: - Networking
    // Now Playing Movies:
    
    func fetchNowPlayingMovies(completion: @escaping (Error?) -> Void) {
        
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?"),
            var components = URLComponents(url: baseURL,
                                           resolvingAgainstBaseURL: true)
            else {
                fatalError ("Unable to set up url and components") }
        
        let apiKeyItem = URLQueryItem(name: "api_key", value: "15a8deba1ab17a4186ef50ddab455438" )
        let languageItem = URLQueryItem(name: "language", value: "en-US")
        let pageItem = URLQueryItem(name: "page", value: "1")
        
        components.queryItems = [apiKeyItem, languageItem, pageItem]
        
        guard let url = components.url else { fatalError ("Components could not construct proper search query") }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                NSLog("Error performing fetch request: \(error)")
                completion(error)
                return }
            
            guard let data = data else {
                NSLog("Could not GET data")
                completion(NSError())
                return }
            
            do{
                let decodedMovie = try JSONDecoder().decode(Movie.self, from: data)
                self.nowPlayingMovies = decodedMovie.results
                completion(nil)
                
            } catch {
                NSLog("Error Decoding Data : \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    // Upcoming Movies:
    
    func fetchUpcomingMovies(completion: @escaping (Error?) -> Void) {
        
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?"),
            var components = URLComponents(url: baseURL,
                                           resolvingAgainstBaseURL: true)
            else {
                fatalError("Unable to set up url and components") }
        
        let apiKeyItem = URLQueryItem(name: "api_key", value: "15a8deba1ab17a4186ef50ddab455438" )
        let languageItem = URLQueryItem(name: "language", value: "en-US")
        let pageItem = URLQueryItem(name: "page", value: "1")
        
        components.queryItems = [apiKeyItem, languageItem, pageItem]
        
        guard let url = components.url else { fatalError ("Components could not construct proper search query") }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error performing fetch request: \(error)")
                completion(error)
                return }
            
            guard let data = data else {
                NSLog("Could not GET data")
                completion(NSError())
                return }
            
            do {
                let decodedMovie = try JSONDecoder().decode(Movie.self, from: data)
                self.upcomingMovies = decodedMovie.results
                completion(nil)
                
            } catch {
                NSLog("Error Decoding Data : \(error)")
                completion(error)
                return }
            
            }.resume()
    }
}

