//
//  DogMVVMTableViewCell.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 08/03/23.
//

import UIKit

final class DogMVVMTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: DogMVVMTableViewCell.self)
    
    //MARK: - IBOutlets
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK: - ViewModel
    var viewModel: DogMVVMCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    //MARK: - Binding
    func bind(viewModel: DogMVVMCellViewModel) {
        self.viewModel = viewModel
        dateLabel.isHidden = true
    }
    
    func bind(vipViewModel: ListDogs.DisplayedDogs) {
        //Bind for VIP architecture demo
        dogNameLabel.text = vipViewModel.name
        dateLabel.text = vipViewModel.date
        
        if let url = URL(string: vipViewModel.imageUrl) {
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
    }
    
    //MARK: - UI
    private func updateUI() {
        dogNameLabel.text = viewModel?.dogName
        viewModel?.loadImage(callback: { [weak self] image in
            //Set image in the main thread
            DispatchQueue.main.async {
                self?.dogImageView.image = image
            }
        })
    }
    
    //MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dogImageView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        dogImageView.image = nil
        dogNameLabel.text = ""
    }
}
