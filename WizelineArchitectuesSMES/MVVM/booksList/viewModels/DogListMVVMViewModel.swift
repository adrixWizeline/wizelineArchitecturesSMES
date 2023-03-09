//
//  DogListViewModel.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 08/03/23.
//

import Foundation

enum DogListAPIStatus {
    case loading
    case finished(data: [Dog])
    case error  //Never happend for this example
}

final class DogListMVVMViewModel: NSObject {
    
    //MARK: - API
    private let api: DogAPI
    
    //MARK: - Handlers for binding
    var loadDogsHandler: ((DogListAPIStatus) -> Void)?
    
    //MARK: - Source
    var source: [Dog] = []
    
    //MARK: - Initializer
    init(api: DogAPI) {
        self.api = api
    }
    
    //MARK: - API
    func loadDogs() {
        //Notify to the view that the service is loading
        loadDogsHandler?(.loading)
        
        //Request Data through network request or BD
        api.getDogs { [weak self] dogsResponse in
            //It notify to the view the result of the dogs
            //and stores the results in the viewModel for
            //future references applying the business logic needed.
            self?.source = dogsResponse
            
            self?.loadDogsHandler?(.finished(data: dogsResponse))
        }
    }
}






