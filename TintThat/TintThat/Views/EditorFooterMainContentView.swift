//
//  EditorFooterMainContentView.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

class EditorFooterMainContentView: UIView {
    
    // MARK: - Properties
    private let topBottomMargins: CGFloat = 12.0
    weak var deletePaletteBtn: UIButton!
    weak var addColorBtn: UIButton!
    weak var editTitleBtn: UIButton!
    
    // MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customRoundCorners(withRadius: 8.0, forCorners: [.bottomLeft, .bottomRight])
    }

}

// MARK: - Private
private extension EditorFooterMainContentView {
    
    func initialSetup() {
        // Setup editTitleBtn
        let editTitleBtn = UIButton(type: .custom)
        editTitleBtn.setImage(.editIcon, for: .normal)
        editTitleBtn.setImage(.editIcon.maskWithColor(color: .lightContext), for: .highlighted)
        editTitleBtn.tintColor = .dark
        editTitleBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(editTitleBtn)
        
        editTitleBtn.topAnchor.constraint(equalTo: topAnchor, constant: topBottomMargins).isActive = true
        editTitleBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomMargins).isActive = true
        editTitleBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        editTitleBtn.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        self.editTitleBtn = editTitleBtn
        
        // Setup addColorBtn
        let addColorBtn = UIButton(type: .custom)
        addColorBtn.setImage(.addIcon.maskWithColor(color: .dark), for: .normal)
        addColorBtn.setImage(.addIcon.maskWithColor(color: .lightContext), for: .highlighted)
        addColorBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addColorBtn)
        
        addColorBtn.topAnchor.constraint(equalTo: topAnchor, constant: topBottomMargins).isActive = true
        addColorBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomMargins).isActive = true
        addColorBtn.leadingAnchor.constraint(equalTo: editTitleBtn.trailingAnchor, constant: 16.0).isActive = true
        addColorBtn.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        
        self.addColorBtn = addColorBtn
        
        // Configure deleteSectionBtn
        let deletePaletteBtn = UIButton(type: .custom)
        deletePaletteBtn.setImage(.deleteIcon.maskWithColor(color: .dark), for: .normal)
        deletePaletteBtn.setImage(.deleteIcon.maskWithColor(color: .lightContext), for: .highlighted)
        deletePaletteBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deletePaletteBtn)
        
        deletePaletteBtn.topAnchor.constraint(equalTo: topAnchor, constant: topBottomMargins).isActive = true
        deletePaletteBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomMargins).isActive = true
        deletePaletteBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        deletePaletteBtn.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        
        self.deletePaletteBtn = deletePaletteBtn
    }
    
}
