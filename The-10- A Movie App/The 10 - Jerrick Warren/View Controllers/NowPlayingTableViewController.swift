//
//  NowPlayingTableViewController.swift
//  The 10 - Jerrick Warren
//
//  Created by Jerrick Warren on 2/14/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

import UIKit

class NowPlayingTableViewController: UITableViewController {

    
    // NARK: - Properties
    
    var movieController = MovieController()
    var baseURL         = URL(string: "https://image.tmdb.org/t/p/w500/")

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MoviesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "movieCell")

       // tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.backgroundColor = .clear
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieController.fetchNowPlayingMovies { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        

     //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieController.nowPlayingMovies.count - 10 
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell

        let record = movieController.nowPlayingMovies[indexPath.row]
        
        cell.contentView.backgroundColor = .black
        cell.movieTitle.textColor        = .white
        cell.movieDescription.textColor  = .white
        cell.releaseDate.textColor       = .white
        
        cell.movieTitle.text             = record.title
        cell.releaseDate?.text           = "Release date: \(record.release_date)"
        cell.movieDescription.text       = record.overview
       
        ImageLoader.fetchImage(from: baseURL?.appendingPathComponent(record.poster_path)) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.movieImage.image    = image
            }
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow?.row else {return}
        
        
        destination.record = movieController.nowPlayingMovies[indexPath]
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: tableView)
    }
    
}
