//
//  HomeTableViewCell.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/26.
//  Copyright © 2018年 athemer. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet
    @IBOutlet weak var title_Label: UILabel!
    @IBOutlet weak var content_TextView: UITextView!
    @IBOutlet weak var photo_CollectionView: UICollectionView!
    
    //MARK: Variables
    fileprivate var model: TouristSpotModel!
    fileprivate var photos: [UIImage] = []
    
    //MARK: Constant
    fileprivate let spacing: CGFloat = 10
    fileprivate let insets: CGFloat = 0
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        configureCollectionView()
        configureContentFont()
    }
    
    private func configureCollectionView()
    {
        let nib = UINib(nibName: .mainCollectionViewCellId, bundle: nil)
        photo_CollectionView.register(nib, forCellWithReuseIdentifier: .mainCollectionViewCellId)
        
        photo_CollectionView.delegate = self
        photo_CollectionView.dataSource = self
        
        photo_CollectionView.isScrollEnabled = true
    }
    
    private func configureContentFont()
    {
        title_Label.textColor = .gray
        content_TextView.textColor = .gray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ model: TouristSpotModel)
    {
        
        self.model = model
        
        title_Label.text = model.stitle
        content_TextView.text = model.content
        
    }
    
}

extension MainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard
            let cell = photo_CollectionView.dequeueReusableCell(withReuseIdentifier: .mainCollectionViewCellId, for: indexPath) as? MainCollectionViewCell
            else { fatalError(" cannot cast mainCollectionViewCell ") }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: spacing, height: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }
    
}
