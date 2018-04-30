//
//  DetailViewController.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/28.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController  {
    
    
    //MARK: Variables
    var presenter: DetailPresentation!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var collectionViewTopConstraint: NSLayoutConstraint?
    
    var collectionViewHeightConstraint: NSLayoutConstraint?
    
    var model: TouristSpotModel! {
        didSet
        {
            createContentArray()
        }
    }
    
    var photoIndex: Int?
    
    
    //MARK: Constant
    private let navigation_Color = UIColor(hex_String: "3EC1ED")
    
    let collectionViewHeight: CGFloat = 200.0
    
    let title_array: [String] = ["景點名稱", "景點地址", "景點介紹"]
    
    var content_array: [String] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureTableView()
        configureCollectionView()
        configurePageControlLayout()
        
        configureNavigation()
        configurePageControl()
        
        presenter.viewDidLoad()
        scroll()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        collectionView.reloadData()
    }
    
    private func scroll(){
        collectionView.scrollToItem(at: IndexPath(item: photoIndex!, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    private func configureTableView()
    {
        
        let nib = UINib(nibName: .detailTableViewCellId, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: .detailTableViewCellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = UIEdgeInsets(top: collectionViewHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -collectionViewHeight)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configurePageControlLayout()
    {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -10).isActive = true
    }
    

    
    private func configureCollectionView()
    {
        
        let nib = UINib(nibName: .detailCollectionViewCellId , bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: .detailCollectionViewCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.allowsSelection = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTopConstraint = collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        collectionViewTopConstraint?.isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
        collectionViewHeightConstraint?.isActive = true
        
    }

    private func configurePageControl()
    {
        pageControl.numberOfPages = model.photoURL?.count ?? 0
    }
    
    private func configureNavigation()
    {
        self.title = model.stitle
        
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = navigation_Color
        navigationController?.navigationBar.tintColor = .white
        
        
    }
    
    private func createContentArray()
    {
        content_array = [ model.stitle, model.location, model.content ]
    }
    
    func changeImageViewTopConstraint(contentOffset: CGPoint)
    {
        
        collectionViewTopConstraint?.isActive = false
        
        collectionViewHeightConstraint?.isActive = false
        
        collectionViewTopConstraint = collectionView.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: -(contentOffset.y - (-collectionViewHeight))
        )
        
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
        
        collectionViewTopConstraint?.isActive = true
        
        collectionViewHeightConstraint?.isActive = true
        
        view.layoutIfNeeded()
    }
    
    func changeImageViewHeightConstraint(contentOffset: CGPoint)
    {
        
        collectionViewTopConstraint?.isActive = false
        
        collectionViewHeightConstraint?.isActive = false
        
        collectionViewTopConstraint = collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: -contentOffset.y)
        
        collectionViewTopConstraint?.isActive = true
        
        collectionViewHeightConstraint?.isActive = true
        
        view.layoutIfNeeded()
    }
}

extension DetailViewController: DetailView {
    
    func showDetailView(_ model: TouristSpotModel, photoIndex: Int) {
        self.model = model
        self.photoIndex = photoIndex
    }
    
    func showNoContentScreen() {
        
    }
    
    func showActivityIndicator() {
        
    }
    
    func hideActivityIndicator() {
        
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return title_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard
            let detailCell = tableView.dequeueReusableCell(withIdentifier: .detailTableViewCellId) as? DetailTableViewCell
            else { fatalError(" cannot cast mainTableViewCell ") }
        
        detailCell.setupCell(title_array[indexPath.row], content: content_array[indexPath.row])
        
        return detailCell
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

extension DetailViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return model.photoURL?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .detailCollectionViewCellId, for: indexPath) as? DetailCollectionViewCell
            else { fatalError(" cannot cast mainCollectionViewCell ") }
        
        cell.setUpCell( model.photoURL?[indexPath.item] )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        switch scrollView {
        case tableView:

            if (scrollView.contentOffset.y > -collectionViewHeight) && (scrollView.contentOffset.y < 20)
            {
                changeImageViewTopConstraint(contentOffset: scrollView.contentOffset)
                
            } else if scrollView.contentOffset.y <= -collectionViewHeight {
                
                changeImageViewHeightConstraint(contentOffset: scrollView.contentOffset)
            }
            
        case collectionView:
            print ("COLLECTIONVIEW")
            pageControl.currentPage = Int( scrollView.contentOffset.x / self.collectionView.frame.width )
        default:
            break
        }
        
    }
    
    
    
}

