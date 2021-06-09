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
        editTitleBtn.setImage(.editIcon.alpha(0.5), for: .highlighted)
        editTitleBtn.tintColor = .primaryAltDark
        editTitleBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(editTitleBtn)
        
        editTitleBtn.topAnchor.constraint(equalTo: topAnchor, constant: topBottomMargins).isActive = true
        editTitleBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomMargins).isActive = true
        editTitleBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        editTitleBtn.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        
        // Setup addColorBtn
        let addColorBtn = UIButton(type: .custom)
        addColorBtn.setImage(.addIcon, for: .normal)
        addColorBtn.setImage(.addIcon.alpha(0.5), for: .highlighted)
        addColorBtn.tintColor = .primaryAltDark
        addColorBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addColorBtn)
        
        addColorBtn.topAnchor.constraint(equalTo: topAnchor, constant: topBottomMargins).isActive = true
        addColorBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomMargins).isActive = true
        addColorBtn.leadingAnchor.constraint(equalTo: editTitleBtn.trailingAnchor, constant: 16.0).isActive = true
        addColorBtn.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        
        // Configure deleteSectionBtn
        let deleteSectionBtn = UIButton(type: .custom)
        deleteSectionBtn.setImage(.deleteIcon, for: .normal)
        deleteSectionBtn.setImage(.deleteIcon.alpha(0.5), for: .highlighted)
        deleteSectionBtn.tintColor = .primaryAltDark
        deleteSectionBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteSectionBtn)
        
        deleteSectionBtn.topAnchor.constraint(equalTo: topAnchor, constant: topBottomMargins).isActive = true
        deleteSectionBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomMargins).isActive = true
        deleteSectionBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        deleteSectionBtn.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
    }
    
}
