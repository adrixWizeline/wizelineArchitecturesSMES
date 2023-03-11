//
//  ListDogsRouter.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 10/03/23.
//

import Foundation
import UIKit

protocol ListDogsRoutingLogic {
    func routeToDetail(dog: Dog)
}

final class ListDogsVIPRouter: ListDogsRoutingLogic {
    weak var view: UIViewController?
    
    func routeToDetail(dog: Dog) {
        let vc = DogDetailVIPViewController(dog: dog)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        print("\(self) \(#function)")
    }
}
