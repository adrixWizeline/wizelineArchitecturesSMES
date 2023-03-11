//
//  DogDetailVIPViewController.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 10/03/23.
//

import UIKit

class DogDetailVIPViewController: UIViewController {
    
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    
    init(dog: Dog) {
        super.init(nibName: "DogDetailVIPViewController", bundle: nil)
        
        bind(withDog: dog)
    }
    
    private func bind(withDog dog: Dog) {
        let viewController = self
        let interactor = ListDogsVIPInteractor()
        let presenter = ListDogsVIPPresenter()
        let router = ListDogsVIPRouter()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
