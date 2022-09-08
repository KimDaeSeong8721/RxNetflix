//
//  CollectionViewTableViewCell.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/05.
//

import UIKit

import RxCocoa
import RxSwift

class CollectionViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
     //   collectionView.backgroundColor = .blue
        collectionView.register(cell: TitleCollectionViewCell.self)
        return collectionView
    }()
    
   // private var images: [String] = [String]()
    private var titles: BehaviorRelay<[Title]> = BehaviorRelay(value: [])
    // FIXME: - 이거를 computed 속성으로 했을때는 연결이 안됐음. 왜지?

    
    private let disposeBag = DisposeBag()
    var delegate: UIViewController?
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cyan
        bindToCollection()
        render()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func
    
    private func render() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
    public func configure(with titles : [Title]) {
        self.titles.accept(titles)
        
    }
    
    private func bindToCollection() {
        titles.asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: TitleCollectionViewCell.className, cellType: TitleCollectionViewCell.self)) { index, title, cell in
                cell.configure(with: title.posterPath ?? "")
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Title.self)
            .subscribe { title in
                guard let titleOverview = title.element?.overview else { return}
                guard let titleName =
                        title.element?.originalTitle ?? title.element?.originalName else {
                    return
                }
                MovieAPI().getMovie(with: titleName + " trailer") { result in
                    switch result {
                    case .success(let videoElement) :
                        let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
                       
                        DispatchQueue.main.async {
                            let detailVC = TitlePreviewViewController()
                            detailVC.configure(with: viewModel)
                            self.delegate?.navigationController?.pushViewController(detailVC, animated: true)
                        }
                       
                    case .failure(let error) :
                        print(error.localizedDescription)
                    }
                }
              
            }.disposed(by: disposeBag)
    }
    
}
