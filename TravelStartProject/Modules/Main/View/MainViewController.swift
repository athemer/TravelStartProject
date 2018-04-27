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
    private let background_Color = UIColor(hex_String: "F6F6F6")
    
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
        presenter.viewDidLoad()
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
        self.models = models
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
        
        mainCell.setupCell(model)
        mainCell.selectionStyle = .none
        
        return mainCell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let model = models[indexPath.row]
        
        presenter.itemDidSelect(model)
    }
}
