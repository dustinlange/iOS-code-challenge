//
//  DetailViewController.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    lazy private var favoriteBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Star-Outline"), style: .plain, target: self, action: #selector(onFavoriteBarButtonSelected(_:)))

    @objc var detailItem: YLPBusiness?
    
    private var _favorite: Bool = false
    private var isFavorite: Bool {
        get {
            return _favorite
        } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        navigationItem.rightBarButtonItems = [favoriteBarButtonItem]
    }
    
    private func configureView() {
        guard let business = detailItem else { return }
        nameLabel.text = business.name
        categoriesLabel.text = "Categories: \(business.categories)"
        ratingLabel.text = "Rating: \(String(business.rating))"
        reviewCountLabel.text = "Number of reviews: \(String(business.reviewCount))"
        priceLabel.text = "Price: \(business.price)"
        setImage(with: business.imageUrlString)
    }
    
    func setBusiness(with newBusiness: YLPBusiness) {
        guard detailItem != newBusiness else { return }
        detailItem = newBusiness
        configureView()
    }

    private func setImage(with imageUrlString: String) {
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.clipsToBounds = true
        guard let imageUrl = URL(string: imageUrlString),
            let data = try? Data(contentsOf: imageUrl) else { return }
        DispatchQueue.main.async {
            self.thumbnailImageView.image = UIImage(data: data)
        }
    }
    
    private func updateFavoriteBarButtonState() {
        favoriteBarButtonItem.image = isFavorite ? UIImage(named: "Star-Filled") : UIImage(named: "Star-Outline")
    }
    
    @objc private func onFavoriteBarButtonSelected(_ sender: Any) {
        _favorite.toggle()
        updateFavoriteBarButtonState()
    }
}
