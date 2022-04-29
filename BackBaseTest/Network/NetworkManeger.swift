//
//  NetworkManeger.swift
//  BackBaseTest
//
//  Created by Veaceslav Chirita on 26.04.2022.
//

import Foundation
import SwiftyJSON

class NetworkManeger {
    
    let urlString = "https://raw.githubusercontent.com/BackbaseRecruitment/city-search-ios-Slava1989/main/cities.json?token=GHSAT0AAAAAABPGD7KGDR4ZZFGS4XOQBS3SYTK45QQ"
    
    func getCities(completion: @escaping ([City]?) -> ()) {
        guard let url = URL(string: urlString) else {
            //TODO: Error message
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let cities = try JSONDecoder().decode([City].self, from: data)
                      completion(cities)
                }
                catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func loadJsonFromFile(completion: @escaping ([City]?) -> ()) {
        if let url = Bundle.main.url(forResource: "Cities", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let cities = try JSONDecoder().decode([City].self, from: data)
                completion(cities)
            } catch {
                print("error:\(error)")
                completion(nil)
            }
        }
    }
    
}
