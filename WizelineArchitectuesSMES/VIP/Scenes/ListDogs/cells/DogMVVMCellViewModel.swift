//
//  DogMVVMCellViewModel.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 08/03/23.
//

import Foundation
import UIKit

final class DogMVVMCellViewModel: NSObject {
    private let dog: Dog
    
    init(dog: Dog) {
        self.dog = dog
        
        super.init()
    }
    
    var dogName: String {
        return String("Name: \(dog.name)")
    }
    
    func loadImage(callback: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: dog.imageUrl) else {
            callback(nil)
            return
        }
        
        //Request out of the main thread
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    callback(loadedImage)
                }
            }
        }
    }
}
