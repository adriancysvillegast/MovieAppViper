//
//  BasicMovieCollectionViewCell.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 9/9/23.
//

import UIKit

class BasicMovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "BasicMovieCollectionViewCell"
    
    private lazy var aImageCover: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleAspectFit
        return aImage
    }()
    
    private lazy var aView: UIView = {
        let aImage = UIView()
        aImage.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return aImage
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [aImageCover, aView, title].forEach {
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
}
