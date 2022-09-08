//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by DaeSeong Kim on 2022/02/19.
//

import UIKit
import WebKit

import SnapKit
class TitlePreviewViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry Potter"
        return label
    }()
    
    
    private let overviewLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as a kid"
        return label
    }()
    
    
    private let downloadButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private let webView : WKWebView = WKWebView()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
     }
    
    override func render() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(94)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(400)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
        }
        view.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view)
        }
        view.addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(overviewLabel.snp.bottom).offset(25)
            make.width.equalTo(140)
            make.height.equalTo(40)
        }
    }
    
    // MARK: - Func
    
    func configure(with model : TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        
        webView.load(URLRequest(url: url))
        
        
    }
   
}
