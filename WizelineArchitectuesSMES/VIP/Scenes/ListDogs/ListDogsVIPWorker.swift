//
//  ListDogsWorker.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 10/03/23.
//

import Foundation

final class ListDogsVIPWorker {
    private let api: DogAPI
    
    init(api: DogAPI) {
        self.api = api
    }
    
    //MARK: - Methods
    func getDogs(callback: @escaping (([Dog]) -> Void)) {
        //It execute the API request and notify to the presenter the results
        api.getDogs { dogs in
            callback(dogs)
        }
    }
    
    deinit {
        print("\(self) \(#function)")
    }
}
