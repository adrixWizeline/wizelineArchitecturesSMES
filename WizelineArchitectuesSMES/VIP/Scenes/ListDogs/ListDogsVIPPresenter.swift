//
//  ListDogsVIPPresenter.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 10/03/23.
//

import Foundation

protocol ListDogsPresentationLogic {
    func presentFetchedDogs(response: DogListAPIStatus)
}

final class ListDogsVIPPresenter: ListDogsPresentationLogic {
    
    weak var viewController: ListDogsDisplayLogic?
    
    let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .short
      dateFormatter.timeStyle = .none
      return dateFormatter
    }()
    
    func presentFetchedDogs(response: DogListAPIStatus) {
        //Send the status response to the view...
        viewController?.receiveStatus(status: response)
        
        //Build the data to be presented
        var displayedDogs = [ListDogs.DisplayedDogs]()
        switch response {
        case .finished(let data):
            for dog in data {
                let date = dateFormatter.string(from: Date())
                displayedDogs.append(.init(name: dog.name,
                                           imageUrl: dog.imageUrl,
                                           date: date))
            }
            
            //Send the data prepared for the view
            viewController?.displayFetcDogs(results: displayedDogs)
            
        default:
            break
        }
    }
    
    deinit {
        print("\(self) \(#function)")
    }
}
