//
//  DetailViewController.swift
//  The 10 - Jerrick Warren
//
//  Created by Jerrick Warren on 2/15/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let indexPath = IndexPath.self
    var record: Results?
    var baseURL = URL(string: "https://image.tmdb.org/t/p/w500/")!
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.navigationItem.leftBarButtonItem?.title = "Back to Movies"
        
        descriptionTextView.layer.cornerRadius       = 20
        descriptionTextView.layer.backgroundColor    = UIColor.white.withAlphaComponent(0.8).cgColor
        descriptionTextView.layer.borderColor        = UIColor.gray.withAlphaComponent(0.5).cgColor
        descriptionTextView.layer.borderWidth        = 0.5
        descriptionTextView.clipsToBounds            = true
        
        movieImage.layer.zPosition   = -1
        movieImage.alpha             = 0.8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let record = record else {return}
        descriptionTextView.text = record.overview
        imageLoader()
    }
    
    
    func imageLoader() {
        ImageLoader.fetchImage(from: baseURL.appendingPathComponent((record?.poster_path)!)) {
            image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.movieImage.image = image
            }
        }
    }
    
}

