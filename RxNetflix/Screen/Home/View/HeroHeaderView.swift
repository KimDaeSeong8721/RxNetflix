//
//  HeroHeaderView.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/05.
//

import UIKit
import SnapKit

class HeroHeaderUIView: UIView {

    // MARK: - Properties
    
    private let playButton : UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
  
    private let downloadButton : UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let HeroImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    addGradient()


        render()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
 // MARK: - Func
    
    private func render() {
        addSubview(HeroImageView)
        HeroImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(70)
            make.bottom.equalTo(self).offset(-50)
            make.width.equalTo(100)
        }
        addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-70)
            make.bottom.equalTo(self).offset(-50)
            make.width.equalTo(100)
        }
    }
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    public func configure(with imageUrl : String){


        guard let url = URL(string:imageUrl) else{return}

        HeroImageView.sd_setImage(with: url, completed: nil)

    }


    
    
}
