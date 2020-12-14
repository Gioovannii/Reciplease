//
//  DescriptionController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/3.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit
//import SDWebImage

final class DescriptionController: UIViewController {
    
    // MARK: - Properties
    
    private let dataSource = DescriptionDataSource()
    var viewModel: DescriptionViewModel?

    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        bind()
    }
    
    func bind() {
        viewModel?.isFavoriteOutput = { [weak self] favorite in
            print(favorite)
            DispatchQueue.main.async {
                switch favorite {
                case false:
                    self?.favoriteButton.image = UIImage(named: "emptyHeart")
                    self?.tableView.reloadData()
                    if self?.tabBarController?.selectedIndex == 1 { self?.navigationController?.popViewController(animated: true)}
                    
                case true:
                    self?.favoriteButton.image = UIImage(named: "fullHeart")
                    self?.tableView.reloadData()
                }
            }
        }
        
        
        viewModel?.recipeOutput = { [weak self] recipe in
            DispatchQueue.main.async {
                if let image = recipe.imageData { self?.recipeImageView?.image = UIImage(data: image) }
                self?.dataSource.update(with: recipe.ingredientLines, title: recipe.label)
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
        guard let shareAs = viewModel?.recipe.shareAs else { return }
        if let url = URL(string: shareAs) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        viewModel?.tapFavorite()
    }
}

