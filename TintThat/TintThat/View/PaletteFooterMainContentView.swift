//
//  PaletteFooterMainContentView.swift
//  TintThat
//
//  Created by Sebastian Cruz on 27/05/21.
//

import UIKit

class PaletteFooterMainContentView: UIView {
    
    // MARK: - Properties
    weak var editTitleBtn: UIButton!
    weak var addColorBtn: UIButton!
    weak var deleteSectionBtn: UIButton!

    // MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    // MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customRoundCorners(withRadius: 8.0, forCorners: [.bottomLeft, .bottomRight])
    }
    
    // Custom methods
    private func initialize() {
        // Configure editTitleBtn
        let editTitleBtn = UIButton()
        editTitleBtn.setImage(UIImage(named: "TestImage"), for: .normal)
        editTitleBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(editTitleBtn)
        
        editTitleBtn.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        editTitleBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        editTitleBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        editTitleBtn.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        
        self.editTitleBtn = editTitleBtn
        
        // Configure addColorBtn
        let addColorBtn = UIButton()
        addColorBtn.setImage(UIImage(named: "TestImage"), for: .normal)
        addColorBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addColorBtn)
        
        addColorBtn.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        addColorBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        addColorBtn.leadingAnchor.constraint(equalTo: self.editTitleBtn.trailingAnchor, constant: 8.0).isActive = true
        addColorBtn.widthAnchor.constraint(equalToConstant: 32.0).isActive = true

        self.addColorBtn = addColorBtn
        
        // Configure deleteSectionBtn
        let deleteSectionBtn = UIButton()
        deleteSectionBtn.setImage(UIImage(named: "TestImage"), for: .normal)
        deleteSectionBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteSectionBtn)
        
        deleteSectionBtn.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        deleteSectionBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        deleteSectionBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0).isActive = true
        deleteSectionBtn.widthAnchor.constraint(equalToConstant: 32.0).isActive = true

        self.deleteSectionBtn = deleteSectionBtn
    }

}
