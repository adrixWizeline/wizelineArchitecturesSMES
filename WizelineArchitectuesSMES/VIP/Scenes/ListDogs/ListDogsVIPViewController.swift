//
//  ListDogsVIPViewController.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 10/03/23.
//

import UIKit

protocol ListDogsDisplayLogic: AnyObject {
    func receiveStatus(status: DogListAPIStatus)
    func displayFetcDogs(results: [ListDogs.DisplayedDogs])
}

final class ListDogsVIPViewController: UIViewController, ListDogsDisplayLogic {
    
    @IBOutlet weak var dogsCounterLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var interactor: ListDogsBusinessLogic?
    private var router: ListDogsVIPRouter?
    private var displayRecords: [ListDogs.DisplayedDogs] = []
    
    init() {
        super.init(nibName: "ListDogsVIPViewController", bundle: nil)
        bind()
    }
    
    //MARK: - Binding
    private func bind() {
        let viewController = self
        let interactor = ListDogsVIPInteractor()
        let presenter = ListDogsVIPPresenter()
        let router = ListDogsVIPRouter()
        
        viewController.router = router
        router.view = self
        //  ( 1 )
        //  Router
        //    ^ |
        //    | v
        //ViewController -> Interactor
        viewController.interactor = interactor
        
        //  ( 2 )
        //... -> Interactor -> Presenter
        interactor.presenter = presenter
        
        //  ( 3 )
        //... -> Interactor -> Presenter -> ViewController
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //Ask the interactor the data needed to show
        interactor?.fetchDogs()
    }
    
    func receiveStatus(status: DogListAPIStatus) {
        switch status {
        case .loading:
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
        case .finished(let dogs):
            self.dogsCounterLabel.text = "Results: \(dogs.count)"
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
        default:
            break
        }
    }
    
    func displayFetcDogs(results: [ListDogs.DisplayedDogs]) {
        displayRecords = results
        tableView.reloadData()
    }
    
    private func setupUI() {
        tableView.register(.init(nibName: "DogMVVMTableViewCell",
                                 bundle: nil), forCellReuseIdentifier: DogMVVMTableViewCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self) \(#function)")
    }
}

extension ListDogsVIPViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DogMVVMTableViewCell.cellIdentifier,
                                                 for: indexPath) as! DogMVVMTableViewCell
        
        cell.bind(vipViewModel: displayRecords[indexPath.row])
        
        return cell
    }
}
