//
//  CoverCollectionViewCell.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/23.
//

import UIKit
import SDWebImage

class CoverCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "CoverCollectionViewCell"
    
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFit
        aImage.layer.cornerRadius = 60
        return aImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
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
    func configuration(artWork: URL?) {
        aImageCover.sd_setImage(with: artWork,
                                placeholderImage: UIImage(named: "image-placeholder"))
    }
}
