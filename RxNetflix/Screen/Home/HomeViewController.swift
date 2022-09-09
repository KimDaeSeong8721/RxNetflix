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

//private enum Sections : Int {
//    case TrendingMovies = 0
//    case TrendingTvs = 1
//    case Popular = 2
//    case Upcoming = 3
//    case TopRated = 4
//
//    var title: String {
//        switch self {
//        case .TrendingMovies:
//            return "Trending Movies"
//        case .TrendingTvs:
//            return "Trending Tv"
//        case .Popular:
//            return "Popular"
//        case .Upcoming:
//            return "Upcoming Movies"
//        case .TopRated:
//            return "Top rated"
//        }
//    }
//}

private enum Size {
    static let rowHeight: CGFloat = 200
    static let sectionHeaderHeight: CGFloat = 40
}

class HomeViewController: BaseViewController, ViewModelBindableType{
    
    // MARK: - Properties
    
    var viewModel: HomeViewModel!
    private var headerView : HeroHeaderUIView?

    private let homeFeedTable : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(cell: CollectionViewTableViewCell.self)
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getTrendingMovies()

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
    func bind() {
        bindToTable()
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
    
    // TODO: - 이것까지 인풋 아웃풋 패턴으로 적용해야할까? 일단은 이벤트가 발생하는 지점에 인풋 아웃풋 패턴 적용
    private func bindToTable() {
        homeFeedTable.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        
        viewModel.titleObservable
            .bind(to: homeFeedTable.rx.items(cellIdentifier: CollectionViewTableViewCell.className, cellType: CollectionViewTableViewCell.self)){ _, titles, cell in
                cell.configure(with: titles)
                cell.bindViewModel(with: self.viewModel)
                cell.delegate = self
            }
            .disposed(by: viewModel.disposeBag)
    }
    
}

// MARK: - Extension

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Size.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Size.sectionHeaderHeight
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView iew: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return Sections.init(rawValue: section)?.title
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
}


