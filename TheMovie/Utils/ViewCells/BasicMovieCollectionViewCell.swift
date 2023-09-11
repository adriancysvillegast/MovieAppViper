//
//  BasicMovieCollectionViewCell.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 9/9/23.
//

import UIKit
import SDWebImage

class BasicMovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "BasicMovieCollectionViewCell"
    
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFit
        return aImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [aImageCover].forEach {
            contentView.addSubview($0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        aImageCover.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aImageCover.image = nil
    }
    
    // MARK: - Methods
    func configuration(model: PopularViewModelCell) {
        aImageCover.sd_setImage(with: model.posterPath)
    }
    
    func configuration(model: NowPlayingViewModelCell) {
        aImageCover.sd_setImage(with: model.posterPath)
    }
    
    func configuration(model: TopRateViewModelCell) {
        aImageCover.sd_setImage(with: model.posterPath)
    }
    
    func configuration(model: UpComingViewModelCell) {
        aImageCover.sd_setImage(with: model.posterPath)
    }
}