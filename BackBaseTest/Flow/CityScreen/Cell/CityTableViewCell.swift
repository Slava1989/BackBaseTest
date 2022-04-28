//
//  CityTableViewCell.swift
//  BackBaseTest
//
//  Created by Veaceslav Chirita on 26.04.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        subTitleLabel.text = ""
    }
    
    func setupCell(city: String, country: String, coordinates: Coord) {
        titleLabel.text = "\(city) \(country)"
        subTitleLabel.text = "\(coordinates.lat) \(coordinates.lon)"
    }
    
    private func configureUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
            
        ])
    }
}
