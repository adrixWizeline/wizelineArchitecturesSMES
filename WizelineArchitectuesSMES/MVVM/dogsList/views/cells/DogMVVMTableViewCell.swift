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
