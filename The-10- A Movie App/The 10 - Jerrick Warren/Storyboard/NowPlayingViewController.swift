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
    
    var movieController = MovieController()
    var moviesCollectionViewCell = MoviesCollectionViewCell()
    var baseURL = URL(string: "https://image.tmdb.org/t/p/w500/")
    
    let reuseIdentifier = "movieHorizontalCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // nowPlayingLabel.layer.zPosition = +1
       // moviesCollectionViewCell.layer.position = CGPoint(x: screenRect.midX, y: screenRect.midY)
        
        
        movieController.fetchNowPlayingMovies { (error) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        // This is resizing my cell 
        

        // Initial Flow Layout Setup
        // let layout = collectionView.collectionViewLayout as! MoviesFlowLayout
       // let standardItemSize = layout.itemSize.height /4  * layout.standardItemScale
        //layout.estimatedItemSize = CGSize(width: standardItemSize, height: standardItemSize)
       //layout.minimumLineSpacing = -(layout.itemSize.width * 0.5)
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
        
        cell.movieTitleLabel.text = record.title
        cell.ratingsLabel.text = String(record.vote_average)
        cell.releaseDateLabel.text = record.release_date
        
        cell.movieImage.layer.borderColor = UIColor.gray.cgColor
        cell.movieImage.layer.borderWidth = 2
        cell.movieImage.clipsToBounds = true
        
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

    
    // Flow Layout
    
    
    
}
