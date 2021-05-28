//
//  PaletteHeaderView.swift
//  TintThat
//
//  Created by Sebastian Cruz on 27/05/21.
//

import UIKit

class PaletteHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    private weak var titleLabel: UILabel!

    // MARK: - Constructors
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    // MARK: - UITableViewHeaderFooterView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
    }
    
    // MARK: - Custom methods
    private func initialize() {
        contentView.backgroundColor = .lightGray
        
        // Configure title label
        let label = UILabel()
        label.text = "My Palette"
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        
        titleLabel = label
    }
    
}
