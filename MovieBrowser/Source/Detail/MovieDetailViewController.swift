//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    static var storyboardIdentifier: String {
        return "MovieDetail"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieDetailViewModel
    
    init?(coder: NSCoder, viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    private func configureView() {
        titleLabel.text = viewModel.movie.title
        let dateString = DateHelper.format(viewModel.movie.releaseDate, from: "yyyy-MM-dd", to: "M/d/yy")
        releaseDateLabel.text = "Release Date: \(dateString)"
        overviewLabel.text = viewModel.movie.overview
        posterImageView.image = viewModel.downloadPoster()
    }
}
