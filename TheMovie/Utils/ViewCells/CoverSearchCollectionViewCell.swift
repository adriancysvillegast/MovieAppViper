//
//  CoverSearchCollectionViewCell.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 16/9/23.
//

import UIKit

class CoverSearchCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "CoverSearchCollectionViewCell"

    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleToFill
        aImage.layer.cornerRadius = 10
        aImage.layer.cornerCurve = .continuous
        return aImage
    }()
    
    private lazy var aSublabel: UILabel = {
        let aLabel = UILabel()
        aLabel.textColor =  .label   //.secondaryLabel
        aLabel.textAlignment = .left
        aLabel.numberOfLines = 2
        return aLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [aImageCover,aSublabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aImageCover.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height-60)
        aSublabel.frame = CGRect(x: 2, y: frame.height-60, width: frame.width-2, height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aImageCover.image = nil
        aSublabel.text = nil
    }
    
    // MARK: - Methods
    func configuration(model: SearchResultViewModelCell) {
        aImageCover.sd_setImage(with: model.posterPath, placeholderImage: UIImage(systemName: "photo"))
        aSublabel.text = model.title
    }
}
