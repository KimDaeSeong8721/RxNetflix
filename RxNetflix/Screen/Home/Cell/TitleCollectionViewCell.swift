//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by DaeSeong Kim on 2022/02/17.
//

import UIKit

import SDWebImage
import SnapKit
class TitleCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        render()
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func render() {
        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    public func configure(with posterPath : String){
        guard let url = URL(string:"https://image.tmdb.org/t/p/w500\(posterPath)") else{return}
        posterImageView.sd_setImage(with: url, completed: nil)
}

}
