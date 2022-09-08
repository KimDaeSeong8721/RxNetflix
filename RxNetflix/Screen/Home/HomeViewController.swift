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
    private var headerView : HeroHeaderUIView?

    private let homeFeedTable : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(cell: CollectionViewTableViewCell.self)
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.getTrendingMovies()
        bindToTable()

    }
    override func render() {
        view.addSubview(homeFeedTable)
        homeFeedTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func configUI() {
        configureHeroHeaderView()
        configureNavbar()
    }
    
    // MARK: - Func
    // TODO: - 이런 함수들도 homeViewModel에 넣어야 할까?
    private func configureHeroHeaderView() {
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        self.headerView?.configure(with: "https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg")
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
        
        homeViewModel.titleObservable
            .bind(to: homeFeedTable.rx.items(cellIdentifier: CollectionViewTableViewCell.className, cellType: CollectionViewTableViewCell.self)){ row, titles, cell in
                cell.configure(with: titles)

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
        return Sections.init(rawValue: section)?.title
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
}


