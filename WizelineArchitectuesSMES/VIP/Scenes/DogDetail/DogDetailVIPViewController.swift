//
//  DogDetailVIPViewController.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 10/03/23.
//

import UIKit

final class DogDetailVIPViewController: UIViewController {
    
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    let dog: ListDogs.DisplayedDog
    
    init(dog: ListDogs.DisplayedDog) {
        self.dog = dog
        super.init(nibName: "DogDetailVIPViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        bind()
    }
    
    private func bind() {
        dogNameLabel.text = dog.name
        if let url = URL(string: dog.imageUrl) {
            //Request out of the main thread
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: url),
                   let loadedImage = UIImage(data: imageData) {
                    //Setting the image in the main thread
                    DispatchQueue.main.async {
                        self?.dogImage.image = loadedImage
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
