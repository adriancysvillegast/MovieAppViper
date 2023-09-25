//
//  GenresCollectionViewCell.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 16/9/23.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "GenresCollectionViewCell"
    
    private var colorsArray = [UIColor(named: "Color01"), UIColor(named: "Color02"), UIColor(named: "Color03"), UIColor(named: "Color04"), UIColor(named: "Color05"), UIColor(named: "Color06"), UIColor(named: "Color07"), UIColor(named: "Color08"), UIColor(named: "Color09"), UIColor(named: "Color10")]
    
    private lazy var aView: UIView = {
       let aView = UIView()
        aView.layer.cornerRadius = 9
        return aView
    }()
    
    private lazy var aLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.numberOfLines = 0
        aLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        aLabel.textColor = .white
        aLabel.textAlignment = .center
        return aLabel
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(aView)
        aView.addSubview(aLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aView.frame = contentView.bounds
        aLabel.frame = aView.bounds
        
    }
    
    // MARK: - Methods
    
    func configuration(model: GenreViewModelCell) {
        guard let color = colorsArray.randomElement() else { return }
        aView.backgroundColor = color
        aLabel.text = model.name
    }
}
