//
//  MainViewController.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/26.
//  Copyright © 2018年 athemer. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Variabels
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainPresentation!
    
    //MARK: Constants
    private weak var background_Color = UIColor(hex_String: "F6F6F6")
    private weak var navigation_Color = UIColor(hex_String: "3EC1ED")
    fileprivate let spacing: CGFloat = 15
    fileprivate let insets: CGFloat = 0
    
    // MARK: DataSource
    var models: [TouristSpotModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureTableView()
        configureNavigation()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "台北市熱門景點"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    private func configureTableView()
    {
        let nib = UINib(nibName: .mainTableViewCellId, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: .mainTableViewCellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = background_Color
        tableView.separatorStyle = .none
    }
    
    private func configureNavigation()
    {
        self.title = "台北市熱門景點"

        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = navigation_Color
        
    }
}

extension MainViewController: MainView {
    
    func showActivityIndicator()
    {
        
    }
    
    func hideActivityIndicator()
    {
        
    }
    
    func showNoContentScreen()
    {
        //Show no content View when no data to show
    }
    
    func showMainData(_ models: [TouristSpotModel])
    {
        self.models = self.models + models
    }
    
}

extension MainViewController: MainTableViewCellDelegate {
    
    func tableViewCellDidSelectPhoto(indexPath: IndexPath, selectedPhotoIndex: Int)
    {
        let model = models[indexPath.row]
        self.title = ""
        presenter.itemDidSelect(model, index: selectedPhotoIndex)
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard
            let mainCell = tableView.dequeueReusableCell(withIdentifier: .mainTableViewCellId) as? MainTableViewCell
            else { fatalError(" cannot cast mainTableViewCell ") }
        
        let model = models[indexPath.row]
        
        mainCell.delegate = self
        
        mainCell.setupCell(model, indexPath: indexPath)
        mainCell.selectionStyle = .none

        return mainCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        
        guard indexPath.row >= models.count - 1 else { return }
        presenter.loadData(withOffset: models.count)
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
}


