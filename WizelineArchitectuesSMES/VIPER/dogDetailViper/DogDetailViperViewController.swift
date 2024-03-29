//
//  DogDetailViperViewController.swift
//  WizelineArchitectuesSMES
//
//  Created Adrian Piedra on 09/03/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DogDetailViperViewController: UIViewController, DogDetailViperViewProtocol {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogsNameLabel: UILabel!
    
    var presenter: DogDetailViperPresenterProtocol?
    
    init() {
        super.init(nibName: "DogDetailViperViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        //Getting the data from the presenter
        if let imageUrl = presenter?.dog.imageUrl, let url = URL(string: imageUrl) {
            //Request out of the main thread
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: url),
                   let loadedImage = UIImage(data: imageData) {
                    //Setting the image in the main thread
                    DispatchQueue.main.async {
                        self?.dogImageView.image = loadedImage
                    }
                }
            }
        }
        
        dogsNameLabel.text = presenter?.dog.name
    }
}
