//
//  ListDogsVIPInteractor.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 10/03/23.
//

import Foundation

protocol ListDogsBusinessLogic {
    func fetchDogs()
}

final class ListDogsVIPInteractor: ListDogsBusinessLogic {
    
    private var dogs: [Dog]
    
    init() {
        self.dogs = []
    }
    
    var presenter: ListDogsVIPPresenter?
    private var dogsWorker: ListDogsVIPWorker = ListDogsVIPWorker(api: DogAPI())
    func fetchDogs() {
        //Notify to the Presenter that the Worker is loading...
        presenter?.presentFetchedDogs(response: .loading)
        
        dogsWorker.getDogs {[weak self] dogs in
            //Save the data in memory
            self?.dogs = dogs
            //Notify to the Presenter the worker is finised and pass the data
            self?.presenter?.presentFetchedDogs(response: .finished(data: dogs))
        }
    }
    
    deinit {
        print("\(self) \(#function)")
    }
}
