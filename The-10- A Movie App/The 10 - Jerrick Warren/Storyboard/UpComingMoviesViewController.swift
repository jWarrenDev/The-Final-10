//
//  UpComingMovies.swift
//  The 10 - Jerrick Warren
//
//  Created by Jerrick Warren on 2/20/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

import UIKit

class UpComingMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nowPlayingLabel: UILabel!
    
    var temp : [Any] = []
    var currentMovie: Int = 0
    var movieController = MovieController()
    var movieCell = MoviesCollectionViewCell()
    var baseURL = URL(string: "https://image.tmdb.org/t/p/w500/")
    
    let reuseIdentifier = "movieHorizontalCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowPlayingLabel.layer.zPosition = +1
        
        
        movieController.fetchUpcomingMovies { (error) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.temp.append(self.movieController.upcomingMovies)
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
        print(temp)
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieController.upcomingMovies.count - 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
        let record = movieController.upcomingMovies[indexPath.row]
        
        cell.movieTitleLabel.text = record.title
        cell.ratingsLabel.text = String(record.vote_average)
        cell.releaseDateLabel.text = "Relsease Date: \(record.release_date)"
        
        
        cell.movieImage.layer.borderWidth = 2
        cell.movieImage.layer.borderColor = UIColor.gray.cgColor
        cell.movieImage.clipsToBounds = true
        
        
        ImageLoader.fetchImage(from: baseURL?.appendingPathComponent(record.poster_path)) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.movieImage.image = image
            }
        }
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.record = sender as? Results
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let record = movieController.upcomingMovies[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: record)
        
    }
    

func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView?.collectionViewLayout as! MoviesFlowLayout
        
        let movieSize = layout.itemSize.height + layout.minimumLineSpacing
        let offset = scrollView.contentOffset.y
        
        currentMovie = Int(floor((offset - movieSize / 2) / movieSize) + 1)
}
    
}








