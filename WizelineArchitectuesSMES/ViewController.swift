//
//  ViewController.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 08/03/23.
//

import UIKit

enum Architecture {
    case mvvm
    case viper
    case vip
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToCleanSwift(_ sender: Any) {
        goToViewWith(architecture: .vip)
    }
    
    private func goToViewWith(architecture: Architecture) {
        switch architecture {
        case .vip:
            let vc = ListDogsVIPViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
}
