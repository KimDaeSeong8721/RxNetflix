//
//  HomeViewController.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/05.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

private enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTvs = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
    
    var title: String {
        switch self {
        case .TrendingMovies:
            return "Trending Movies"
        case .TrendingTvs:
            return "Trending Tv"
        case .Popular:
            return "Popular"
        case .Upcoming:
            return "Upcoming Movies"
        case .TopRated:
            return "Top rated"
        }
    }
}

class HomeViewController: BaseViewController{
    
    
    // MARK: - Properties
    
    var homeViewModel = HomeViewModel()
    
    private let homeFeedTable : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(cell: CollectionViewTableViewCell.self)
        tableView.backgroundColor = .red
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToTable()
    }
    override func render() {
        view.addSubview(homeFeedTable)
        homeFeedTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func configUI() {
      //  configureHeroHeaderView()
        configureNavbar()
    }
    
    // MARK: - Func
    
    private func configureHeroHeaderView() {
        // viewmodel
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    private func bindToTable() {
        homeFeedTable.rx.setDelegate(self).disposed(by: homeViewModel.disposeBag)
        
        homeViewModel.imageObservable
            .bind(to: homeFeedTable.rx.items(cellIdentifier: CollectionViewTableViewCell.className, cellType: CollectionViewTableViewCell.self)){ row, images, cell in
                print(row)
                cell.configure(with: images)

            }
            .disposed(by: homeViewModel.disposeBag)
    }
    
}

// MARK: - Extension

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView iew: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("바보")
        return Sections.init(rawValue: section)?.title
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
}


