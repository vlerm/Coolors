//
//  CoolorsTableViewCell.swift
//  Coolors
//
//  Created by Вадим Лавор on 11.08.22.
//

import UIKit

class CoolorsTableViewCell: UITableViewCell {
    
    lazy var coolorsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var coolorsTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var coolorsView: CoolorsView = {
        let coolorsView = CoolorsView()
        return coolorsView
    }()
    
    var unsplashImage: UnsplashImage? {
        didSet{
           updateViews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coolorsView.colors = [UIColor(named: "offWhite")!]
    }
    
    func updateViews(){
        guard let unsplashPhoto = unsplashImage else { return }
        parseAndSetImage(for: unsplashPhoto)
        parseAndSetColors(for: unsplashPhoto)
        coolorsTitleLabel.text = unsplashPhoto.description
    }
    
    func parseAndSetImage(for unsplashImage: UnsplashImage) {
        UnsplashParser.shared.fetchImage(for: unsplashImage) { (image) in
            DispatchQueue.main.async {
                self.coolorsImageView.image = image
            }
        }
    }
    
    func parseAndSetColors(for unsplashImage: UnsplashImage) {
        ImageService.shared.parseColors(imagePath: unsplashImage.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                self.coolorsView.colors = colors
            }
        }
    }
    
    func setupViews(){
        addAllSubviews()
        let imageWidth = (contentView.frame.width - (SpacingConstants.horizontalPadding * 2))
        coolorsImageView.anchor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: SpacingConstants.verticalPadding, paddingBottom: 0, paddingLeft: SpacingConstants.horizontalPadding, paddingRight: SpacingConstants.horizontalPadding, width:imageWidth , height: imageWidth)
        coolorsTitleLabel.anchor(top: coolorsImageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectPadding, paddingBottom: 0, paddingLeft: SpacingConstants.horizontalPadding, paddingRight: SpacingConstants.horizontalPadding, width: nil, height: SpacingConstants.oneLineObjectHeight)
        coolorsView.anchor(top: coolorsTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectPadding, paddingBottom: SpacingConstants.verticalPadding, paddingLeft: SpacingConstants.horizontalPadding, paddingRight: SpacingConstants.horizontalPadding, width: nil, height: SpacingConstants.twoLineObjectHeight)
        coolorsView.clipsToBounds = true
        coolorsView.layer.cornerRadius = (SpacingConstants.twoLineObjectHeight / 2)
    }
    
    func addAllSubviews() {
        addSubview(coolorsImageView)
        addSubview(coolorsTitleLabel)
        addSubview(coolorsView)
    }
    
}
