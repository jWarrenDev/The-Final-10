//
//  UpComingMovies.swift
//  The 10 - Jerrick Warren
//
//  Created by Jerrick Warren on 2/20/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

import UIKit

class UpComingMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nowPlayingLabel: UILabel!
    
    var movieController = MovieController()
    var baseURL = URL(string: "https://image.tmdb.org/t/p/w500/")
    
    let reuseIdentifier = "movieHorizontalCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowPlayingLabel.layer.zPosition = +1
        
        
        movieController.fetchUpcomingMovies { (error) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    
    
    
    // Do any additional setup after loading the view.
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieController.upcomingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
        let record = movieController.upcomingMovies[indexPath.row]
        
        cell.movieTitleLabel.text = record.title
        cell.ratingsLabel.text = String(record.vote_average)
        cell.releaseDateLabel.text = String(record.release_date)
        
        
        
        ImageLoader.fetchImage(from: baseURL?.appendingPathComponent(record.poster_path)) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.movieImage.image = image
            }
        }
        
        return cell
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
