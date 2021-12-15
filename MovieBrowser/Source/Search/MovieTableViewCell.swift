//
//  MovieTableViewCell.swift
//  MovieBrowser
//
//  Created by Jason Goodney on 12/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        
        if !movie.releaseDate.isEmpty {
            releaseDateLabel.text = DateHelper.format(movie.releaseDate, from: "yyyy-MM-dd", to: "MMMM d, yyyy")
        }
        
        ratingLabel.text = "\(movie.voteAverage)"
    }

}
