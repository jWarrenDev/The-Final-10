//
//  MoviesViewController.swift
//  The 10 - Jerrick Warren
//
//  Created by Jerrick Warren on 2/19/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nowPlayingLabel: UILabel!
    
    var screenRect = UIScreen.main.bounds
    
    var currentMovie = 0
    var movieController = MovieController()
    var moviesCollectionViewCell = MoviesCollectionViewCell()
    var baseURL = URL(string: "https://image.tmdb.org/t/p/w500/")
    
    let reuseIdentifier = "movieHorizontalCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieController.fetchNowPlayingMovies { (error) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
            self.collectionView.reloadData()
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return movieController.nowPlayingMovies.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
       // Trying to make the cell start in the center of the screen 
       // cell.layer.position = CGPoint(x: screenRect.maxX * 0.5, y: screenRect.maxY / 2 )
        
         let record = movieController.nowPlayingMovies[indexPath.row]
        
        cell.movieTitleLabel.textColor = .white
        
        cell.movieTitleLabel.text   = record.title
        cell.ratingsLabel.text      = String(record.vote_average)
        cell.releaseDateLabel.text  = "Relsease Date: \(record.release_date)"
        
        cell.movieImage.layer.borderColor   = UIColor.gray.cgColor
        cell.movieImage.layer.borderWidth   = 2
        cell.movieImage.clipsToBounds       = true
        
        ImageLoader.fetchImage(from: baseURL?.appendingPathComponent(record.poster_path)) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.movieImage.image = image
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nowDetailSegue" {
            let detailViewController    = segue.destination as! DetailViewController
            detailViewController.record = (sender as? Results)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let record = movieController.nowPlayingMovies[indexPath.row]
        performSegue(withIdentifier: "nowDetailSegue", sender: record)
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView?.collectionViewLayout as! MoviesFlowLayout
        
        let movieSize = layout.itemSize.height + layout.minimumLineSpacing
        let offset = scrollView.contentOffset.y
        
        currentMovie = Int(floor((offset - movieSize / 2) / movieSize) + 1)
    }

   
    
    
    
}
