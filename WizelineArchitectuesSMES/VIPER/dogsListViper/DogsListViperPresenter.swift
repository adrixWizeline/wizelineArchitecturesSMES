//
//  DogsListViperPresenter.swift
//  WizelineArchitectuesSMES
//
//  Created Adrian Piedra on 09/03/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

final class DogsListViperPresenter: DogsListViperPresenterProtocol {
    
    //MARK: - DogsListViperPresenterProtocol Properties
    private(set) var source: [Dog]

    weak private var view: DogsListViperViewProtocol?
    var interactor: DogsListViperInteractorProtocol?
    private let router: DogsListViperRouterProtocol?
    
    //MARK: - Initializers
    init(interface: DogsListViperViewProtocol, interactor: DogsListViperInteractorProtocol?, router: DogsListViperRouterProtocol?) {
        //Bind
        self.view = interface   // Presenter -> View
        self.interactor = interactor    // Presenter -> Interactor
        self.router = router    // Presenter -> Router
        
        self.source = []
    }
    
    //MARK: - DogsListViperPresenterProtocol Methods
    func getDogs() {
        //Send status to the view that the network request is loading
        view?.didLoadDogs(status: .loading)
        
        //It executes the Network / DB request
        interactor?.getDogs()
    }
    
    //Interactor execute this method when it completes the request.
    func didLoadDogs(status: DogListAPIStatus) {
        //If the status is finished, it stores the data...
        switch status {
        case .finished(let data):
            source = data
            
        default:
            break
        }
        
        //Notify to the view the new status with the data.
        view?.didLoadDogs(status: status)
    }
    
    func dogTapped(dog: Dog) {
        router?.goToDogDetail(dog: dog)
    }
}