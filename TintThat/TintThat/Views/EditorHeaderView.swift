//
//  EditorHeaderView.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

class EditorHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    private weak var titleLabel: UILabel!
    
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }

    // MARK: - Constructors
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewHeaderFooterView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
    }

}

// MARK: - Private
private extension EditorHeaderView {
    
    func initialSetup() {
        contentView.backgroundColor = .light
        
        // Setup title label
        let label = UILabel()
        label.textColor = .dark
        label.font = .customHeadline
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16.0).isActive = true
        
        titleLabel = label
    }
    
}
