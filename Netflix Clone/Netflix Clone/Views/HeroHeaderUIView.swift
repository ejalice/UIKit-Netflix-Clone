//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by eunji on 2022/07/12.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    /* CGColor vs UIColor
     : CGColor: Core Graphics framework에서 사용하는 요소의 색상값.
     : UIColor: UIKit framework에서 사용하는 요소의 색상값.
     
     - view < UIView < UIKit framework => UIColor 사용
     - layer < Core Graphics => UIColor.색상.cgColor : UIColor를 CGColor로 변경 후 사용.
     
     - UIKit framework: User Interface에서 다루는 것.
     - Core Graphics: iOS에서 '그리기'를 담당.
     */
    
    private let playButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false // auto layout을 사용하여 View의 크기와 위치를 동적으로 계산
        return button
    }()
    
    private let downloadButton: UIButton = {
       
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let heroImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true // clipsToBounds: subview가 view의 경계를 넘어가면 잘림.
        imageView.image = UIImage(named: "heroImage")
        
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer() // 그라데이션
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [
            /* leadingAnchor -> Global App 만들 때 필수.
             : 언어별로 시작하는 위치가 다름. (시작 위치)
             - 우리나라 / 영어: 왼->오 => leadingAnchor: 왼
             - 아랍: 오->왼 => leadingAnchor: 오
            */
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    public func configure(with model: TitleViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
