//
//  DogListMVVMViewController.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 08/03/23.
//

import UIKit

final class DogListMVVMViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - ViewModel
    let viewModel: DogListMVVMViewModel
    
    //MARK: - Initializers
    init(viewModel: DogListMVVMViewModel) {
        //Binding
        self.viewModel = viewModel
        
        super.init(nibName: "DogListMVVMViewController", bundle: nil)
        
        bind()
    }
    
    //MARK: - Binding
    private func bind() {
        viewModel.loadDogsHandler = {[weak self] dogsStatus in
            switch dogsStatus {
            case .loading:
                self?.activityIndicator.isHidden = false
                self?.activityIndicator.startAnimating()
                
            case .finished(let dogs):
                self?.counterLabel.text = "Results: \(dogs.count)"
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                
                self?.tableView.reloadData()
                
            default:
                break
            }
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
        viewModel.loadDogs()
    }
    
    //MARK: - Methods
    private func setupUI() {
        title = "MVVM"
        tableView.register(.init(nibName: "DogMVVMTableViewCell", bundle: nil), forCellReuseIdentifier: DogMVVMTableViewCell.cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DogListMVVMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DogMVVMTableViewCell.cellIdentifier,
                                                 for: indexPath) as! DogMVVMTableViewCell
        
        let dog = viewModel.source[indexPath.row]
        //Create the ViewModel for the cell
        cell.bind(viewModel: DogMVVMCellViewModel(dog: dog))
        
        return cell
    }
}



