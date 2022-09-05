//
//  HomeViewController.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/05.
//

import UIKit

private enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTvs = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
// MARK: - Properties
    
    private let homeFeedTable : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(cell: CollectionViewTableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func configureHeroHeaderView() {
        
    }
}
