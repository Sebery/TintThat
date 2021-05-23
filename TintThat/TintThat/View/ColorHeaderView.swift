//
//  ColorHeaderView.swift
//  TintThat
//
//  Created by Sebastian Cruz on 23/05/21.
//

import UIKit

class ColorHeaderView: UITableViewHeaderFooterView {
    
    private weak var titleField: UITextField!
    private weak var mainStack: UIStackView!
    private weak var addColorButton: UIButton!
    
    // MARK: - UITableViewHeaderFooterView
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    // MARK: - Custom Methods
    private func initialize() {
        // Create mainStack
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
    
        mainStack.axis = .horizontal
        mainStack.distribution = .fillEqually
        mainStack.alignment = .fill
        mainStack.spacing = 8
        
        // Add titleTextField field to main stack
        let titleField = UITextField()
        titleField.text = "My Palette"
        self.titleField = titleField
        mainStack.addArrangedSubview(titleField)
        
        // Add addColorButton to main stack
        let addColorButton = UIButton(type: .system)
        addColorButton.contentHorizontalAlignment = .right
        addColorButton.setTitle("Add", for: .normal)
        self.addColorButton = addColorButton
        mainStack.addArrangedSubview(addColorButton)
        
        mainStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        
        contentView.backgroundColor = .white
    }
    
}
