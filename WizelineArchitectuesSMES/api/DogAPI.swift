//
//  DogAPI.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 08/03/23.
//

import Foundation
final class DogAPI {
    
    //Simulate network request and it takes 2 seconds for response
    func getDogs(callback: @escaping (([Dog]) -> Void)) {
        if let url = Bundle.main.url(forResource: "dogsapi", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let dogs = try decoder.decode([Dog].self, from: data)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    callback(dogs)
                }
            } catch {
                print("error:\(error)")
            }
        }
    }
}
