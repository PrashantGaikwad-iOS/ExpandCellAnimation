//
//  ViewController.swift
//  ExpandCellAnimation
//
//  Created by Prashant G on 11/21/18.
//  Copyright © 2018 MyOrg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    // 1
    var expandedLabel: UILabel!
    var indexOfCellToExpand: Int!
    // 2
    var movies: [[String: AnyObject]]!
    var selectedMovie: [String: AnyObject]!
    var selectedMoviePhoto: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Expand Cell"
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.prefersLargeTitles = true
        
        indexOfCellToExpand = -1
        tableView.dataSource = self
        tableView.delegate = self
        
        movies = [[String: AnyObject]]()
        let url = URL(string: "http://sweettutos.com/movies.json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let results = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String:AnyObject]
                    self.movies = (results["movies"] as! [[String: AnyObject]])
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }catch {
                    print("An error occurred")
                }
            }
        }
        task.resume()
    }
    
    func expandCell(sender: UITapGestureRecognizer)
    {
        let label = sender.view as! UILabel
        let cell: MovieTableViewCell = tableView.cellForRow(at: IndexPath(row: label.tag, section: 0)) as! MovieTableViewCell
        let movie = self.movies[label.tag]
        let description = movie["Description"] as! String
        cell.movieDescription.sizeToFit()
        cell.movieDescription.text = description
        expandedLabel = cell.movieDescription
        indexOfCellToExpand = label.tag
        tableView.reloadRows(at: [IndexPath(row: label.tag, section: 0)], with: .fade)
        tableView.scrollToRow(at: IndexPath(row: label.tag, section: 0), at: .top, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! MovieTableViewCell
        let movie = self.movies[indexPath.row]
        let photoURL = movie["Photo"] as! String
        let title = movie["Title"] as! String
        let intro = movie["Intro"] as! String
        cell.movieTitle.text = title
        cell.movieDescription.text = intro
        cell.movieDescription.tag = indexPath.row
        //let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.expandCell(sender:)))
        //cell.movieDescription.addGestureRecognizer(tap)
        cell.movieDescription.isUserInteractionEnabled = true
        // Download the photo using the SDWebImage library
        // cell.movieImageView.sd_setImage(with: URL(string: photoURL))
        cell.movieImageView.loadImageUsingCacheFromUrl(urlString: photoURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == indexOfCellToExpand {
            return 150 + expandedLabel.frame.height - 35
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.expandCellAgain(sender: indexPath.row)
    }
    
    func expandCellAgain(sender: Int) {
        // let label = sender.view as! UILabel
        
        let cell: MovieTableViewCell = tableView.cellForRow(at: IndexPath(row: sender, section: 0)) as! MovieTableViewCell
        let movie = self.movies[sender]
        let description = movie["Description"] as! String
        cell.movieDescription.sizeToFit()
        cell.movieDescription.text = description
        expandedLabel = cell.movieDescription
        indexOfCellToExpand = sender
        tableView.reloadRows(at: [IndexPath(row: sender, section: 0)], with: .fade)
        tableView.scrollToRow(at: IndexPath(row: sender, section: 0), at: .top, animated: true)
    }
    
}
