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
        collectionView.backgroundColor = .blue
        collectionView.register(cell: TitleCollectionViewCell.self)
        return collectionView
    }()
    
   // private var images: [String] = [String]()
    private var images: BehaviorRelay<[String]> = BehaviorRelay(value: ["https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg"])
    
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
    public func configure(with images: [String]) {
        self.images.accept(images)
    }
    
    private func bindToCollection() {
        images.asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: TitleCollectionViewCell.className, cellType: TitleCollectionViewCell.self)) { index, imageUrl, cell in
                cell.configure(with: imageUrl)
            }
            
    }
    
}
