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
    let background_Color = UIColor(hex_String: "F6F6F6")
    let navigation_Color = UIColor(hex_String: "3EC1ED")
    
    fileprivate let spacing: CGFloat = 15
    fileprivate let insets: CGFloat = 0
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .gray
        return indicator
    }()
    
    lazy var reconnect_Button: UIButton = {
       let btn = UIButton()
        btn.setTitle("點按以重試", for: .normal)
        btn.setTitleColor(navigation_Color, for: .normal)
        btn.addTarget(nil, action: #selector(button_Action), for: .touchUpInside)
        return btn
    }()
    
    // MARK: DataSource
    var models: [TouristSpotModel] = [] {
        didSet{
            tableView.isHidden = false
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
        
        tableView.isHidden = true
        
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
    
    fileprivate func showReconnectButton()
    {
        reconnect_Button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(reconnect_Button)
        
        NSLayoutConstraint.activate([
            reconnect_Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reconnect_Button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    @objc fileprivate func button_Action()
    {
        presenter.loadData(withOffset: models.count)
        removeRecoonectButton()
    }
    
    fileprivate func removeRecoonectButton()
    {
        reconnect_Button.removeFromSuperview()
    }
}

extension MainViewController: MainView {
    
    func showActivityIndicator()
    {
        
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
    }
    
    func hideActivityIndicator()
    {
        activityIndicator.removeFromSuperview()
    }
    
    func showNoInternetConnect()
    {
        let alert = UIAlertController(title: "注意", message: "在沒有網路連線的狀態下無法取得資料", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { [unowned self] action in
            guard self.models.count <= 0 else { return }
            self.showReconnectButton()
        }))
        alert.addAction(UIAlertAction(title: "立即重試", style: .default, handler: { [unowned self] action in
            self.presenter.loadData(withOffset: self.models.count)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError()
    {
        let alert = UIAlertController(title: "注意", message: "獲取資料錯誤", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "立即重試", style: .default, handler: { [unowned self] action in
            self.presenter.loadData(withOffset: self.models.count)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoMoreDataToShowAlert()
    {
        let alert = UIAlertController(title: "注意", message: "沒有更多資料囉", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "確認", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func useCachedResponseAlert()
    {
        let alert = UIAlertController(title: "注意", message: "在沒有網路連線的狀態下無法取得最新資料\n是否使用先前緩存過的資料", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "使用", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "立即重試", style: .default, handler: { [unowned self] action in
            self.presenter.loadData(withOffset: self.models.count)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoContentScreen()
    {
        let label = UILabel()
        label.text = "此 api 沒有回傳可顯示之資料"
        label.font = UIFont(name: "PingFang TC", size: 16)
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
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
        let viewModel = MainTableViewCellViewModel(model: model)
        
        mainCell.delegate = self
        mainCell.setupCell(viewModel, indexPath: indexPath)

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


