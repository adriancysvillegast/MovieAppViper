//
//  TextCollectionViewCell.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/23.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "TextCollectionViewCell"
    
    private lazy var aSublabel: UILabel = {
        let aLabel = UILabel()
        aLabel.textColor =  .label   //.secondaryLabel
        aLabel.textAlignment = .justified
        aLabel.numberOfLines = 0
        return aLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [aSublabel].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aSublabel.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aSublabel.text = nil
    }
    
    // MARK: - Methods
    func configuration(overview: String ) {
        aSublabel.text = overview
    }
}
